RAILS_DEFAULT_LOGGER.info ">> Adding importer Fat Free CRM plugin..."

FatFreeCRM::Plugin.register(:importer) do
         name "Importer Fat Free CRM Plugin"
       author "Tom Meier"
      version "0.2"
  description "Import mapped sources into Fat Free CRM."
end

require "crm_salesforce_importer.rb"
