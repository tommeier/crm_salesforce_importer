module Salesforce
  class WsdlProperties
    require 'rexml/document'
    include REXML
  
    #Capture the WSDL file and generate all relevent object properties for use in mapping with data mapper (simple timesaver - edit to make the classes actually work)
    def self.generate
       xml = File.read(Salesforce.wsdl_location) 
       doc = Document.new(xml)
     
       objects = {}
       doc.each_element('//definitions/types/schema/complexType') { |i| 
           object_elements = []
           i.each_element('complexContent/extension/sequence/element') { |element| 
              #name='ABN__c' nillable='true' minOccurs='0' type='xsd:double' 
              object_elements << element
           }                           
           objects.update(i.attributes['name'].to_sym => object_elements) unless object_elements.blank? 
         }
     
       #Strip out unnecessary SalesForce objects (ignored at this stage as they're not required or not wanted right now
       ignored_objects = %w( ApexTrigger ApexClass ApexComponent ApexPage ApiQueryFault Approval AsyncApexJob BusinessHours ) 
       unusable_objects = %w( ProcessInstanceHistory EmailStatus OpenActivity ActivityHistory NoteAndAttachment ) #Unable to make queries on
       
       #Objects skipped because I am unsure how to deal with them yet... Eg. MassMailMessage is an object OF Email.
       skipped_objects = %w( SingleEmailMessage MassEmailMessage ProcessWorkitemRequest ProcessSubmitRequest )
       objects.delete_if {|key, value| (ignored_objects + unusable_objects + skipped_objects).include?(key.to_s) }
       
       FileUtils.mkdir_p(temp_dir = "#{RAILS_ROOT}/tmp/sales_force_import")
       filename = "dm_mapped_objects.rb" 
       output = File.open(File.join(temp_dir, filename), 'w') { |f|
         
       f << "module DataMapper\n"
       f << " class Objects\n" 
       objects.keys.collect{|k| k.to_s}.sort.each do |k|
          #k = object (eg. Account / Lead)
          #v = elements of object
          belongs_to_objects = []
          belongs_to_id_objects = []
          has_n_objects = []
          unknown_objects = []
          standard_objects = []
          custom_objects = []
          #puts " ** #{k}"
          objects[k.to_sym].each do |element|
             element_attrs = element.attributes.symbolize_keys
             element_name, element_type = self.clean_input(element_attrs)
             if element_name[-3,3] == '__c'
                #puts "    - #{element_name}"
                custom_objects << element_attrs
                next
             end
             #next if element_name[-3,3] == '__r' #ignore record objects.. No idea what to do with them yet
             next if element_name == "alias" #Ignore Alias field, fails on User + Name model
             
             case element_type
             when "tns:id"
               belongs_to_id_objects << element_attrs
             when "tns:query_result" 
               has_n_objects << element_attrs
             when "tns:email_file_attachment"
               #do nothing - unhandled types
             when "xsd:base64_binary", "xsd:int", "xsd:double", "xsd:string", "xsd:date_time", "xsd:boolean", "xsd:date", "xsd:any_type", "xsd:time"
               standard_objects << element_attrs   
             else
               #ens objects are the full objects for relationships
               if element_type.to_s[0,3] == 'ens'
                  #Element used for belongs to relationship
                  belongs_to_objects << element_attrs
               else
                 puts "UNKNOWN ELEMENT : #{element_attrs.inspect}"
                 unknown_objects << element_attrs 
               end
             end
           
          end
               #Lead with notes : 00Q200000087VGt
               
          #Generate class item
          f << self.print_class(k, standard_objects, {:belongs_to => belongs_to_objects, :belongs_to_id => belongs_to_id_objects, :custom => custom_objects, :unknown => unknown_objects, :has_n => has_n_objects})
        
          #Print error message for all unknown classes
          
       end 
       f << "  end\nend\n"
       }
       puts "Salesforce --> Datamapper objects printed to #{File.join(temp_dir, filename)}..."
       puts "Please edit and fix up accordingly."
       puts "You can then override the functionality of the plugins version by putting in your lib directory."
       puts "A LOT of the has_many relationships will be broken. The generator is just meant to give you a quick output to work and fiddle with."

          
   
       return doc
    end

  
    def self.print_class(klass, objects, options = {})
       #TODO : turn this into a proper generator! (when you're not being hassled by a boss preferably)
       raise "Error - please pass the class/object to be printed" if klass.blank?
       raise "Error - please pass the objects for the class to be printed" if klass.blank?
     
       belongs_to_objects = options[:belongs_to] if options.include?(:belongs_to)
       belongs_to_id_objects = options[:belongs_to_id] if options.include?(:belongs_to_id)
       custom_objects = options[:custom] if options.include?(:custom)
       unknown_objects = options[:unknown] if options.include?(:unknown)
       has_n_objects = options[:has_n] if options.include?(:has_n)
       
       klass_name = klass.to_s.camelize
       klass_name = "#{klass_name.chomp('_c')}__c" if klass_name[-2,2] == '_c' #Handle camelize converting double underscores
       output = ""
       output += "\n    class #{klass_name}"
       output += "\n      include DataMapper::Resource"
       output += "\n"
       output += "\n       def self.default_repository_name"
       output += "\n         :salesforce"
       output += "\n       end"
       output += "\n"
       output += "\n       def self.salesforce_id_properties"
       output += "\n         :id"
       output += "\n       end"
       output += "\n"
       output += "\n       property  :id, String, :serial => true"
       objects.dup.each do |obj|
         name, type = self.clean_input(obj)
         dm_type = self.datamapper_type(type)
         output += "\n       property  :#{name.to_s}, #{dm_type}"   
       end
       
       output += "\n\n       #Custom fields for CLEAR version of SalesForce " unless custom_objects.blank?
       custom_objects.dup.each do |obj|
          name, type = self.clean_input(obj)
          dm_type = self.datamapper_type(type)
          output += "\n       property  :#{name.to_s}, #{dm_type}"   
       end
       output += "\n\n       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')" unless belongs_to_id_objects.blank?
       belongs_to_id_objects.dup.each do |obj|
          name, type = self.clean_input(obj)
          dm_type = self.datamapper_type(type)
          output += "\n       property  :#{name.to_s}, #{dm_type}"   
       end
       output += "\n\n       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)" unless belongs_to_objects.blank?
       belongs_to_objects.dup.each do |obj|
           name, type = self.clean_input(obj)
           dm_type = self.datamapper_type(type)
           type.slice!(0,4)
           output += "\n       #belongs_to  :#{name.to_s}, :class_name => '#{type.camelize}', :child_key => [:#{name}_id] #Reference : #{type.camelize}"
       end
  
       output += "\n\n       #Has many relationships - May need configuration" unless has_n_objects.blank?
       has_n_objects.dup.each do |obj|
          #TODO : Set child key (eg Notes = has n,  :notes, :child_key => [ :parent_id ] )
          name, type = self.clean_input(obj)
          output += "\n       has n,  :#{name.to_s}"   
       end
       
       output += "\n\n       #Belongs to relationships manually set via object gets until DM 10.* is implemented" unless belongs_to_objects.blank?
       belongs_to_objects.dup.each do |obj|
          name, type = self.clean_input(obj)
          type.slice!(0,4)
          source = "#{name}_id"
          if name[-3,3] == '__r'
            name.slice!(-3,3)
            source = "#{name}__c"
          end
          if type.camelize == "Name"
            #Belongs to not working properly on the polymorphic relationships. Do in this horrible hacky method until better way presents itself.
            output += "\n       def #{name.to_s}; User.get(self.#{source}) || Lead.get(self.#{source}) || Account.get(self.#{source}) || Contact.get(self.#{source}) || Opportunity.get(self.#{source}); end"
          else
            output += "\n       def #{name.to_s}; #{type.camelize}.get(self.#{source}); end"
          end
       end
       output += "\n    end"
       output += "\n"
       output                             
    end 
  
    private
  
    def self.datamapper_type(type)
      #Convert salesforce type to datamapper type
      output = ""
      case type.to_s.downcase
      when "tns:id"
        output = "String"
      when "xsd:base64_binary"
        output = "String" #Should be BCryptHash - Haven't had a chance to test dm-types gem yet.
      when "xsd:int"
        output = "Integer"
      when "xsd:double"
        output = "Fixnum"
      when "xsd:string"
        output = "String"
      when "xsd:date_time"
        output = "DateTime"
      when "xsd:date"
        output = "Date"
      when "xsd:time"
        output = "Time"
      when "xsd:any_type"
        output = "String"
      when "xsd:boolean"
        output = "Boolean"
      else
        output = "UnknownConversion:#{type}"
      end 
      output
    end
  
    def self.clean_input(attrs)
      element_type = attrs[:type].to_s.underscore.strip
      element_name = attrs[:name].to_s.underscore
      return element_name, element_type
    end
  
  end
end        