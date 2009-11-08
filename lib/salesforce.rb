require 'rubygems'
gem 'dm-core', '=0.9.11'
require 'dm-core'
require 'dm-salesforce'

#Bring in datamapper objects
require 'data_mapper/dm_mapped_objects.rb'
require 'properties_generator.rb'

class Comment < ActiveRecord::Base
  def log_activity
    #Do nothing - #Needs updated AuthLogic to prevent load on these non-controller-based-tasks
  end
end

module Salesforce
   
  def self.wsdl_location
    wsdl_location = File.join(Rails.root, "config", "salesforce", "wsdl.xml")
    raise "Error - please ensure your WSDL file is saved from Salesforce to : '#{wsdl_location}'" unless File.exist?(wsdl_location)
    wsdl_location
  end
   
  def self.import
    #Raise connection if not initialized already   
    conn = DataMapper::DmConnection.new unless DataMapper::DmConnection.connection.present?
    
    #User.delete_all!
    Account.delete_all!
    Contact.delete_all!
    Opportunity.delete_all!
    AccountOpportunity.delete_all
    AccountContact.delete_all
    Lead.delete_all!
    
    Task.delete_all!
    Comment.delete_all
    
    import_users
    import_accounts
    import_contacts 
    import_opportunities
    import_leads
    import_tasks
    import_notes
                     
  end 
  
  def self.list_total_content
    conn = DataMapper::DmConnection.new unless DataMapper::DmConnection.connection.present? 
    #List total content available on the SalesForce connection based on the objects mapped
    totals = []
    non_zero = []
    DataMapper::Objects.local_constant_names.each do |klass|
       begin
       puts "Attempting to process - #{klass.to_s}..."
       obj_klass = "DataMapper::Objects::#{klass.to_s}".constantize
       size = obj_klass.all.size
       if size >= 0 
          msg = "#{klass.to_s} - Total items : #{obj_klass.all.size}"
          totals << msg
          non_zero << msg if size > 0
       end
       rescue Exception => e
          puts "    ** Unable to calculate - #{klass.to_s} - #{e.message}"
       end
    end
    
    unless totals.blank?
       puts "Totals loaded : "
       totals.each {|i| puts i}
    end
    
    unless non_zero.blank?
       puts "Items greater than 0 : "
       non_zero.each {|i| puts i }
    end
  end  

  private
  
  def self.import_users
    
    #CRM User columns:
    #  "username",
    #  "email",
    #  "first_name",
    #  "last_name",
    #  "title",
    #  "company",
    ##  "alt_email",
    #  "phone",
    #  "mobile",
    ##  "aim",
    ##  "yahoo",
    ##  "google",
    ##  "skype",
    ##  "password_hash",
    ##  "password_salt",
    ##  "persistence_token",
    ##  "perishable_token",
    ##  "last_request_at",
    ##  "last_login_at",
    ##  "current_login_at",
    ##  "last_login_ip",
    ##  "current_login_ip",
    ##  "login_count",
    ##  "deleted_at",
    ##  "created_at",
    ##  "updated_at",
    ##  "admin",
    ##  "suspended_at"] 
    
    #SalesForce User columns:
    #:user_role => UserRole object
    #:profile => user.profile.name if "System Administrator" for setting "admin"
    
    # :username,                      String
    # :email,                             String
    # :first_name,                        String 
    # :last_name,                         String
    # :title,                      String 
    # :company_name,                      String
    # :phone,                             String
    # :mobile_phone,                      String  
    # :is_active,                         Boolean --> suspended_at
    
    #Custom User columns required 
    # :fax,                               String               
    # :street,                            String 
    # :city,                              String                                                                                                                        
    # :postal_code,                       String                                                                        
    # :state,                             String                                                     
    # :country                            String                                                    
    
    #---------------------------------------------------------------------------
    
    
    user_counter = 0
    DataMapper::Objects::User.all.each do |u|
       #Import each User into FFCRM
       #Initial password
       default_password = "test123"
       profile = u.profile.name
       admin = profile == "System Administrator" ? true : false 
       suspended_date = u.is_active ? u.created_date : nil
       
       crm_user = User.new 
       crm_user.password = default_password
       crm_user.password_confirmation = default_password
       
       update_values = {
         :username => u.username,
         :email => u.email,
         :first_name => u.first_name,
         :last_name => u.last_name,
         :title => u.title,
         :company => u.company_name,
         :phone => u.phone, 
         :mobile => u.mobile_phone,
         :admin => admin,
         :suspended_at => suspended_date 
       }
       
       address_details = %w( street city state postal_code country )
       address = address_details.collect{|i| u.send(i) }.compact.join(', ')

       custom_values = {
         :fax => u.fax,
         :address => address           
       }
       update_values.update(custom_values)
       
       #Avoid mass assignment protection
       update_values.each do |k,v|
         crm_user[k] = v
       end
       crm_user.save!
       user_counter +=1 
       
    end
    puts "\n ** #{user_counter} users imported..."
    
  end
  
  def self.import_accounts 
    
    #Salesforce Account fields
    # 
    # :name,
    # :website,
    # :phone,
    # :fax,
    # :is_deleted, => convert to deleted_at
    
    #owner => user_id (maybe assigned_to also)
    
    #Set array of incoming columns and join to new field.
    # :billing_street,                                                                                                                                                                                            
    # :billing_city,                                                        
    # :billing_country,                                                     
    # :billing_postal_code,                                                 
    # :billing_state,                                                       
    # :shipping_street,                                                               
    # :shipping_city,                                                       
    # :shipping_country,                                                    
    # :shipping_postal_code,                                                
    # :shipping_state,
                                                                                                             
    # :description,                                                         
                                                                                                               
    # #Custom salesforce fields                                             
    # :abn__c,                                                                                                               
    # :acn__c,                                                                                          
    # :bhc_used_for_grower_delivery__c,                                                                               
    # :grn_number__c,                                                       
    # :grn_type__c,                                                               
    # :registration_type__c,                                                      
    # :relationship_to_clear__c,                                  
    # :rough_guide_to_grain_volume_mt__c,                                  
    # :what_grains_do_you_trade_in__c,                                                
                                                              
                                                                               
    # #CRM Account columns:
                                                             
    #  "user_id",                                                                   
    #  "assigned_to",                                                               
    #  "name",                                                                      
    #  "access",
    #  "website",
    #  "toll_free_phone",
    #  "phone",
    #  "fax",
    #  "billing_address",
    #  "shipping_address",
    #  "deleted_at",
    #  "created_at",
    #  "updated_at"
    
    #custom Account columns required
    # :description
    # :abn__c,                                                                                                               
    # :acn__c,                                                                                          
    # :bhc_used_for_grower_delivery__c,                                                                               
    # :grn_number__c,                                                       
    # :grn_type__c,                                                               
    # :registration_type__c,                                                      
    # :relationship_to_clear__c,                                  
    # :rough_guide_to_grain_volume_mt__c,                                  
    # :what_grains_do_you_trade_in__c,
    
    
    account_counter = 0
     #Generate Accounts
    DataMapper::Objects::Account.all.each do |a| 
        crm_account = Account.new
        
        address_details = %w( street city state postal_code  country )
        shipping_address = address_details.collect{|i| "shipping_#{i}"}.collect{|i| a.send(i) }.compact.join(', ')
        billing_address  = address_details.collect{|i| "billing_#{i}"}.collect{|i| a.send(i) }.compact.join(', ') 
        
        #( shipping_address + billing_address ).each { |i| crm_account[i] = a.send(i) }
        sf_user = DataMapper::Objects::User.get(a.owner_id)
        crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
        raise "Error - Unable to find user for account - #{a.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
        
        other_names = Account.find(:all, :conditions => ["accounts.name = ? OR accounts.name like ('%#{a.name} (Duplicate :%')", a.name])
        
        name = other_names.size > 0 ? "#{a.name.gsub(/.(Duplicate : .*)/, "")} (Duplicate : #{other_names.size})" : a.name
        deleted_at = a.is_deleted ? DateTime.now : nil  
        
        update_values = {
           :user_id => crm_user.id,          
           :assigned_to => crm_user.id,    
           :name => name,         
           :website => a.website,
           :access => "Public", 
           :toll_free_phone => nil,
           :phone => a.phone,
           :fax => a.fax,
           :billing_address => billing_address,
           :shipping_address => shipping_address,
           :deleted_at => deleted_at
         } 
         custom_values = {
           :description => a.description,
           :abn => a.abn__c,                               
           :acn => a.acn__c,                                                       
           :registration_type => a.registration_type__c,                  
           :relationship_to_clear => a.relationship_to_clear__c,              
           :rough_guide_to_grain_volume_mt => a.rough_guide_to_grain_volume_mt__c,     
           :what_grains_do_you_trade_in => a.what_grains_do_you_trade_in__c         
         }
         update_values.update(custom_values) 
         
        #Avoid mass assignment protection
        update_values.each do |k,v|
           crm_account[k] = v
        end
        crm_account.save!
        account_counter += 1
        
    end
    puts "\n ** #{account_counter} accounts imported."
    
  end
   
  def self.import_contacts 
    #CRM fields:
    # "id",
    #  "uuid",
    #  "user_id",
    #  "lead_id",
    #  "assigned_to",
    #  "reports_to",
    #  "first_name",
    #  "last_name",
    #  "access",
    #  "title",
    #  "department",
    #  "source",
    #  "email",
    #  "alt_email",
    #  "phone",
    #  "mobile",
    #  "fax",
    #  "blog",
    #  "linkedin",
    #  "facebook",
    #  "twitter",
    #  "address",
    #  "born_on",
    #  "do_not_call",
    #  "deleted_at",
    #  "created_at",
    #  "updated_at"
    
    #Salesforce Fields
    # :assistant_name
    # :assistant_phone
    # :birthdate
    # :created_date
    # :department
    # :description
    # :email
    # :email_bounced_date
    # :email_bounced_reason
    # :fax
    # :first_name
    # :home_phone
    # :is_deleted
    # :last_activity_date
    # :last_cu_request_date
    # :last_cu_update_date
    # :last_modified_date
    # :last_name
    # :lead_source
    # :mailing_city
    # :mailing_country
    # :mailing_postal_code
    # :mailing_state
    # :mailing_street
    # :mobile_phone
    # :name
    # :other_city
    # :other_country
    # :other_phone
    # :other_postal_code
    # :other_state
    # :other_street
    # :phone
    # :salutation
    # :system_modstamp
    # :title
    # 
    # #relationship fields
    # :account_id
    # :created_by_id
    # :last_modified_by_id
    # :master_record_id
    # :owner_id
    # :reports_to_id  
    
    contact_counter = 0
     #Generate Contacts
    DataMapper::Objects::Contact.all.each do |c| 
        crm_contact = Contact.new
        
        address_details = %w( street city state postal_code country )
        mailing_address = address_details.collect{|i| "mailing_#{i}"}.collect{|i| c.send(i) }.compact.join(', ')
        other_address   = address_details.collect{|i| "other_#{i}"}.collect{|i| c.send(i) }.compact.join(', ') 
        
        sf_user = DataMapper::Objects::User.get(c.owner_id)
        crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
        raise "Error - Unable to find user for account - #{c.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
        
        deleted_at = c.is_deleted ? DateTime.now : nil  
        
        update_values = {
           :user_id => crm_user.id,
           :lead_id => nil,
           :assigned_to => crm_user.id,
           :reports_to => nil,
           :first_name => c.first_name,
           :last_name => c.last_name,
           :access => "Public",
           :title => c.title, 
           :source => c.lead_source,
           :email => c.email,
           :phone => c.home_phone,
           :mobile => c.mobile_phone,
           :fax => c.fax, 
           :address => (mailing_address || other_address),
           :born_on => c.birthdate,
           :deleted_at => deleted_at          
           
         } 

        #Avoid mass assignment protection
        update_values.each do |k,v|
           crm_contact[k] = v
        end
        crm_contact.save!
        
        account = c.account
        if account.present?
           conditions = {:name => account.name }
           crm_object = Account.find(:first, :conditions => conditions)
           AccountContact.create!(:account_id => crm_object.id, :contact_id => crm_contact.id, :deleted_at => deleted_at) if crm_object.present?                    
        end
        contact_counter += 1
        
    end
    puts "\n ** #{contact_counter} contacts imported."     
    
  end
  
  def self.import_opportunities
    #CRM Fields
    # "id",
    #    "uuid",
    #    "user_id",
    #    "campaign_id",
    #    "assigned_to",
    #    "name",
    #    "access",
    #    "source",
    #    "stage",
    #    "probability",
    #    "amount",
    #    "discount",
    #    "closes_on",
    #    "deleted_at",
    #    "created_at",
    #    "updated_at" 
    
    #Salesforce fields:
    # amount
    # close_date
    # created_date
    # description
    # fiscal
    # fiscal_quarter
    # fiscal_year
    # forecast_category
    # forecast_category_name
    # has_opportunity_line_item
    # is_closed
    # is_deleted
    # is_won
    # last_activity_date
    # last_modified_date
    # lead_source
    # name
    # next_step
    # probability, Fixnum
    # stage_name
    # system_modstamp
    # type
    # 
    # relationship fields manually until DM 10.*
    # account_id
    # created_by_id
    # last_modified_by_id
    # owner_id
    # pricebook2_id  
    
    op_counter = 0
     #Generate Contacts
    DataMapper::Objects::Opportunity.all.each do |o| 
        crm_opportunity = Opportunity.new
                
        sf_user = DataMapper::Objects::User.get(o.owner_id)
        crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
        raise "Error - Unable to find user for opportunity - #{o.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
        
        deleted_at = o.is_deleted ? DateTime.now : nil  
        
        update_values = {
           :user_id => crm_user.id,
           :campaign_id => nil,
           :assigned_to => crm_user.id, 
           :name => o.name,
           :access => "Public",
           :source => o.lead_source, 
           :stage => self.convert_opportunity_stage(o.stage_name),
           :probability => nil,
           :amount => o.amount,
           :discount => nil,
           :closes_on => o.close_date,
           :deleted_at => deleted_at
         }
         
         custom_values = {
           :description => o.description
         }
         update_values.update(custom_values) 

        #Avoid mass assignment protection
        update_values.each do |k,v|
           crm_opportunity[k] = v
        end
        crm_opportunity.save!
        
        account = o.account
        if account.present?
           conditions = {:name => account.name }
           crm_object = Account.find(:first, :conditions => conditions)
           AccountOpportunity.create!(:account_id => crm_object.id, :opportunity_id => crm_opportunity.id, :deleted_at => deleted_at) if crm_object.present?                    
        end
        op_counter += 1                             
        
    end
    puts "\n ** #{op_counter} opportunities imported."                            
    
            
  end
  
  def self.import_leads
    puts " - Importing leads"
    #-----------------------------------------------------------------------------
    
    #Salesforce Lead Fields
    #     owner_id  => user_id
    #     campaign => campaign_id (find in CRM)
    #     first_name
    #     last_name
    #     title 
    #     company 
    #     lead_source
    
    #     status => trim numbers from input
    #     email
    #     phone
    #     mobile_phone   
        
    #compile into => "address" 
    #     street
    #     city
    #     state
    #     postal_code
    #     country
    #     description
    #     website
 
    #     Custom Salesforce fields  
    #     mobile__c 
    #     abn__c
    #     acn__c
    #     bhc_used_for_grower_delivery__c
    #     fax__c
    #     grn_number__c
    #     grn_type__c
    #     growers_broker__c  => growers_broker (Account)
    #     if_growers_broker_is_not_clear_user__c 
    #     registration_type__c => ["Grower", "Buyer", "Other", "Broker"]
    #     rough_guide_to_grain_volume_mt__c
    #     what_grains_do_you_trade_in__c
    #     feedback__c

    
    #CRM Lead fields
     # "user_id",
     # "assigned_to",
     # "first_name",
     # "last_name",
     # "access", (default => Public)
     # "title",
     # "company",
     # "source",
     # "status",
     # "referred_by",
     # "email",
     # "alt_email",
     # "phone",
     # "mobile",
     # "blog",
     # "linkedin",
     # "facebook",
     # "twitter",
     # "address",
     # "rating",
     # "do_not_call",
     # "deleted_at",
     # "created_at",
     # "updated_at" 
    
     #Lead Custom fields:
     #description
     #website
     #     mobile__c 
     #     abn__c
     #     acn__c
     #     bhc_used_for_grower_delivery__c 
     # mobile__c                                                      
     # abn__c
     # acn__c
     # bhc_used_for_grower_delivery__c
     # fax__c
     # grn_number__c
     # grn_type__c
     # growers_broker__c  => growers_broker (Account)
     # if_growers_broker_is_not_clear_user__c 
     # registration_type__c => ["Grower", "Buyer", "Other", "Broker"]
     # rough_guide_to_grain_volume_mt__c
     # what_grains_do_you_trade_in__c
     # feedback__c
     
     
    leads_counter = 0
     unable = []   
    #Generate Leads
    DataMapper::Objects::Lead.all.each do |l| 
        crm_lead = Lead.new
        
        address_details = %w( street city state postal_code  country )
        lead_address = address_details.collect{|i| l.send(i) }.compact.join(', ')
        
        sf_user = DataMapper::Objects::User.get(l.owner_id)
        if sf_user.present?
          crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
          raise "Error - Unable to find user for account - #{l.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
        else
          crm_user = User.first
          #puts "Unable to find user from lead owner id - : #{l.owner_id}, replacing with first user."
          unable << l.owner_id
        end
        
        deleted_at = l.is_deleted ? DateTime.now : nil  
        
        lead_status = l.status
        lead_status.slice!(0,3) if lead_status.slice(0,1).to_i < 10 #Strip numbers - only ever single digits in Salesforce system
        
        sf_broker = l.growers_broker
         if sf_broker.present? && sf_broker.is_a?(DataMapper::Objects::Account)
                conditions = {:name => sf_broker.name}
                crm_object = Account.find(:first, :conditions => conditions)
                crm_broker_id = crm_object.id if crm_object.present?  
         end
         
         update_values = {
           :user_id => crm_user.id,
           :assigned_to => crm_user.id,    
           :first_name => l.first_name,
           :last_name => l.last_name,
           :access => "Public",
           :title => l.title,
           :company => l.company,
           :source => self.convert_lead_source(l.lead_source),
           :status => self.convert_lead_status(lead_status),
           :email => l.email,
           :phone => l.phone,
           :mobile => l.mobile__c,#l.mobile_phone,                       
           :address => lead_address,
           :blog => l.website,
           :deleted_at => deleted_at
         }
          
         custom_values = {
           :description => l.description,
           :abn => l.abn__c,                               
           :acn => l.acn__c,                               
           :bhc_used_for_grower_delivery => l.bhc_used_for_grower_delivery__c,
           :fax => l.fax__c, 
           :grn_number => l.grn_number__c,                         
           :grn_type => l.grn_type__c,
           :growers_broker_id => crm_broker_id, 
           :if_growers_broker_is_not_clear_user => l.if_growers_broker_is_not_clear_user__c,
           :registration_type => l.registration_type__c,                             
           :rough_guide_to_grain_volume_mt => l.rough_guide_to_grain_volume_mt__c,     
           :what_grains_do_you_trade_in => l.what_grains_do_you_trade_in__c,
           :feedback => l.feedback__c         
         }                                                                   
         update_values.update(custom_values) 
         
        #Avoid mass assignment protection
        update_values.each do |k,v|
           crm_lead[k] = v
        end
        crm_lead.save! 
        leads_counter += 1
                       
    end
    unless unable.size <= 0
      puts "\n ** Unable to assign #{unable.size} leads" 
      unable_grouped = unable.uniq.map{|x| [x,unable.select{|y| y == x}.length]} 
      unable_grouped.each do |u|
         puts "\nOwner id #{u[0]} failed #{u[1]} times."
      end
    end
    puts "\n ** #{leads_counter} leads imported.\n"
  end

  def self.import_tasks
     puts "\n ** Importing tasks..."
     #---------------------------------------------------------------------------------------------------
     #Task Salesforce fields:
     #owner => #user_id + assigned_to
     # activity_date
     # completed_by

     # created_by
     # subject
     # description

     # is_closed => set completed_by & completed_at if so
     # is_deleted => set deleted_at (to activity_date)

     # priority
     # status

     #CRM Columns
     #  "user_id",
     #  "assigned_to",
     #  "completed_by", => user_id IF completed 
     #  "name",
     #  "asset_id",
     #  "asset_type",
     #  "priority",
     #  "category",
     #  "bucket",
     #  "due_at",
     #  "completed_at",
     #  "deleted_at",
     #  "created_at",
     #  "updated_at"

     #Custom fields required 
     #  description
     
     task_counter = 0
     unable = []
     DataMapper::Objects::Task.all.each do |t| 
               crm_task = Task.new
               sf_user = DataMapper::Objects::User.get(t.owner_id) 
          
               if sf_user.present?
                 crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
                 raise "Error - Unable to find user for account - #{t.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
               else
                 crm_user = User.first
                 #puts "Unable to assign task with owner_id of #{t.owner_id}"
                 unable << t.owner_id
               end

               deleted_at = t.is_deleted ? DateTime.now : nil 
               completed_by = completed_at = nil 
               if t.is_closed || t.status == "Completed"
                 completed_by = crm_user.id
                 completed_at = t.activity_date
               end
               
               task_for = t.who #Only currently can handle lead as source data requires only this so far (+Contact)
               if task_for.present? && task_for.is_a?(DataMapper::Objects::Lead)
                    conditions = {:first_name => task_for.first_name, :last_name => task_for.last_name, :email => task_for.email, :company => task_for.company}
                    crm_object = Lead.find(:first, :conditions => conditions)
                    if crm_object.present?
                      asset_id    = crm_object.id 
                      asset_type  = "Lead"
                    end  
               end 
               #t.what => Opportunity / Account 
                
                case t.subject.to_s
                when /call/
                  task_category = 'Call'
                when /email/
                  task_category = 'Email'
                end
                  
                update_values = { 
                  :user_id => crm_user.id, 
                  :assigned_to => crm_user.id, 
                  :completed_by => completed_by,
                  :name => t.subject,
                  :asset_id => asset_id,
                  :asset_type => asset_type,
                  :priority => t.priority,
                  :category => task_category, 
                  :bucket => "due_later",
                  :due_at => t.activity_date,
                  :completed_at => completed_at,
                  :deleted_at => deleted_at,
                  :created_at => t.activity_date,
                  :updated_at => t.activity_date
                }
                custom_values = {
                  :description => t.description,      
                }                                                                   
                update_values.update(custom_values) 
               
               #Avoid mass assignment protection
               update_values.each do |k,v|
                  crm_task[k] = v
               end
               crm_task.save!                       
               task_counter += 1
     end
           unless unable.size <= 0
             puts "\n ** Unable to assign #{unable.size} tasks" 
             unable_grouped = unable.uniq.map{|x| [x,unable.select{|y| y == x}.length]} 
             unable_grouped.each do |u|
                puts " -- Owner id #{u[0]} failed #{u[1]} times."
             end
           end 
           puts "\n ** #{task_counter} tasks imported."
  end
   
  def self.import_notes
     puts "\n ** Importing Notes..."
     #-------------------------------------------------------------------------------------------
     #Notes Salesforce Fields 

     # created_date
     # is_deleted
     # is_private
     # title
     # body 
     # created_by_id
     # owner_id
     # parent_id  - User/Account/Lead/Opportunity        

     #CRM COlumns (Comments)
     #  "user_id",
     #  "created_at"
     #  "commentable_id",
     #  "commentable_type",
     #  "private",
     #  "title",
     #  "comment",
     
     comment_counter = 0
     unable = []

      DataMapper::Objects::Note.all.each do |n| 
                crm_comment = Comment.new
                sf_user = DataMapper::Objects::User.get(n.owner_id) 

                if sf_user.present?
                  crm_user = User.find_with_deleted(:first, :conditions => {:username => sf_user.username}) 
                  raise "Error - Unable to find user for account - #{n.inspect}.\nPlease ensure the full usernames were saved in User model.\nIt could need the field size increased (if the user object saved)." if crm_user.blank? #Users should have been loaded and *should* be there
                else
                  crm_user = User.first
                  unable << n.owner_id
                end

                 note_for = n.parent
                 if note_for.present? 
                      
                      crm_object = self.objects_map[note_for.class]
                      raise "Error - Unable to map object - #{note_for.inpsect}\n to CRM object" if crm_object.blank?
                      case crm_object.to_s
                      when "Lead", "User", "Contact"
                        conditions = {:first_name => note_for.first_name, :last_name => note_for.last_name, :email => note_for.email, :company => note_for.company}
                      when "Opportunity", "Task"
                        conditions = {:name => note_for.name}
                      when "Account"
                        conditions = {:name => note_for.name, :website => note_for.website}
                      else
                        raise "Unrecognized Object to find : #{crm_object.to_s}"
                      end
                      crm_object = crm_object.find(:first, :conditions => conditions)
                      if crm_object.present?
                        commentable_id    = crm_object.id 
                        commentable_type  = crm_object.class.to_s
                      end
                 else   
                    raise "Error - Cannot find parent : #{n.inspect}"
                 end
                 
                 
                 update_values = { 
                   :user_id => crm_user.id,
                   :commentable_id => commentable_id,
                   :commentable_type => commentable_type,
                   :private => false,
                   :title => n.title,
                   :comment => n.body
                 }

                #Avoid mass assignment protection
                update_values.each do |k,v|
                   crm_comment[k] = v
                end
                crm_comment.save!                       
                comment_counter += 1
      end
      unless unable.size <= 0
        puts "\n ** Unable to assign #{unable.size} comments." 
        unable_grouped = unable.uniq.map{|x| [x,unable_grouped.select{|y| y == x}.length]} 
        unable_grouped.each do |u|
           puts " -- Owner id #{u[0]} failed #{u[1]} times."
        end
      end 
      puts "\n ** #{comment_counter} comments (notes) imported."         
            
            
  end
  
  def self.convert_lead_status(sf_status)
    case sf_status.to_s.downcase
    when 'registration', 'expression of interest', 'client application'
      status = 'new'  
    when "registration complete", "clear approval process", "registration", 'referred to website'
      status = 'contacted'
    when 'closed - no application'
      status = 'rejected'
    else
      status = nil#'other'  
    end
    status
  end
  
  def self.convert_lead_source(sf_source)
    case sf_source.to_s.downcase
    when "grower seminar", "broker seminar"
      source = "conference"
    when "internet"
      source = "online"
    when "media article", "newsletter", "advertisement"
      source = "campaign" 
    when "broker", "clear representative"
      source = "referral"  
    when "word of mouth"
      source = "word_of_mouth"
    when "grower signup form"
      source = "web"
    else
      source = "other"
    end
    source
  end

  def self.convert_opportunity_stage(sf_stage)         
    case sf_stage.to_s.downcase
    when "prospecting", "qualification"
      crm_stage = sf_stage.to_s.downcase  
    when "needs analysis", "id. descision makers", "perception analysis"
      crm_stage = "analysis"
    when "value proposition", "proposal/price quote"
      crm_stage = "proposal"
    when "negotiation/review"
      crm_stage = "negotiation"
    when "closed won"
      crm_stage = "won"
    when "closed lost"
      crm_stage = "lost"
    else
      crm_stage = "prospecting"
    end
    crm_stage
  end

  def self.objects_map(options = {})
    #Salesforce => CRM objects   
    
    #CRM OBJECTS :
    # Account Contacts
    # Account Opportunities
    # Accounts
    # Activities
    # Avatars
    # Campaigns
    # Comments
    # Contact Opportunities
    # Contacts
    # Leads
    # Opportunities
    # Permissions
    # Preferences
    # Schema Migrations
    # Sessions
    # Settings
    # Tasks
    # Users   
    
    #Salesforce Objects
    #To view list of objects run Salesforce.list_total_content with a fully loaded dm_mapped_objects.rb file
    
    #These are just objects required for me to map in this import. Enhance and add for more objects:
    #    LeadStatus - Total items : 9 
    #    Account - Total items : 150  
    #    Lead - Total items : 1000
    #    User - User 
    #    Task - Total items : 1000 (Find objects to associate manually)
    #    TaskStatus - Total items : 5
    #    EmailTemplate - Total items : 109 
    #    Note - Total items : 119 (Find objects via association manually) 
      
    @objects_map = {  DataMapper::Objects::User => User,
                      DataMapper::Objects::Account => Account,
                      DataMapper::Objects::Opportunity => Opportunity,
                      DataMapper::Objects::Contact => Contact,
                      DataMapper::Objects::Lead => Lead,
                      DataMapper::Objects::Task => Task,
                      DataMapper::Objects::Note => Comment
                      }.update(options)
  end
  
  def self.columns_map(options = {})
    #CRM Object => {salesforce_column => crm_column}
     
    #Do manually until this can be done nicely with mapped columns!
    #sf_column => crm_column
    # @columns_map = {  :User => {},
    #                   :Account => {},
    #                   :Lead => {},
    #                   :Task => {  :owner => [:user, :assigned_to],
    #                               :activity_date => :completed_by,
    #                               :is_closed => :completed_by,
    #                               :created_by => :user
    #                               
    #                               
    #                   },
    #                   :Comment => {:created_date => :created_at,
    #                                [:owner_id, :created_by_id] => :user_id,
    #                                :parent => :commentable,
    #                                :is_private => :private,
    #                                :title => :title,
    #                                :body => :comment,
    #                                }
    #                   }.update(options) 
  end

end
