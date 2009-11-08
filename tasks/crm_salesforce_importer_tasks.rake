namespace :fatfree do  
  namespace :importer do  
    description = "Import all Salesforce data"  
    description << ". Update config/database.yml with salesforce connection details."  
    desc description 
    task :import_salesforce => :environment do 
      FatFreeCrm::SalesforceImporter.import 
    end  
  end 
end 