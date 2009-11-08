module DataMapper
  class DmConnection
  cattr_accessor :connection

    def initialize
      #Load security values from yml
      c = YAML.load(File.open("#{Rails.root}/config/salesforce/salesforce.yml").read)
      if c["salesforce"]
        c["salesforce"].symbolize_keys
      else
        raise "No salesforce configuration found for importing data in: #{Rails.root}/config/salesforce/salesforce.yml"
      end

      %w( security_token username password ).each do |var|
         raise "Error - Please ensure '#{var}' values are included in #{Rails.root}/config/salesforce/salesforce.yml" if c["salesforce"][var].blank?
      end

      wsdl_location = Salesforce.wsdl_location

      self.connection = DataMapper.setup( :salesforce, {
        :adapter    => 'salesforce',
        :username   => c['salesforce']['username'],
        :password   => "#{c['salesforce']['password']}#{c['salesforce']['security_token']}",
        :path       => wsdl_location,
        :host       => ''
      })
    end 
  end
end
