require File.join(File.expand_path(File.dirname(__FILE__)),"salesforce.rb")
 

module FatFreeCrm
  include Salesforce

  class SalesforceImporter
    
    def initialize; end
    
    def self.import
      begin
        Salesforce.import
      rescue Exception => e
        raise "Error - A problem occured while processing salesforce import. \n\n#{e.to_s}\n#{e.backtrace.join('\n')}"
      end
    end

  end  
end

