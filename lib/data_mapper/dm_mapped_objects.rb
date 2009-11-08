module DataMapper
 class Objects

    class Account
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :annual_revenue, Fixnum
       property  :billing_city, String
       property  :billing_country, String
       property  :billing_postal_code, String
       property  :billing_state, String
       property  :billing_street, String
       property  :created_date, DateTime
       property  :description, String
       property  :fax, String
       property  :industry, String
       property  :is_deleted, Boolean
       property  :last_activity_date, Date
       property  :last_modified_date, DateTime
       property  :name, String
       property  :number_of_employees, Integer
       property  :phone, String
       property  :shipping_city, String
       property  :shipping_country, String
       property  :shipping_postal_code, String
       property  :shipping_state, String
       property  :shipping_street, String
       property  :system_modstamp, DateTime
       property  :type, String
       property  :website, String

       #Custom fields for CLEAR version of SalesForce 
       property  :abn__c, Fixnum
       property  :abn_sent_to_d_b__c, Boolean
       property  :acn__c, Fixnum
       property  :accounts_created_for_all_team_members__c, Boolean
       property  :bhc_used_for_grower_delivery__c, String
       property  :bulk_grower_list_returned__c, Boolean
       property  :company_trading_diagram_finalised__c, Boolean
       property  :d_b_report_ordered_on__c, Date
       property  :d_b_report_returned_on__c, Date
       property  :estimated_grain_volume_in_08_09_mt__c, Fixnum
       property  :estimated_growers_to_service_in_08_09__c, Fixnum
       property  :external_id__c, String
       property  :grn_number__c, Fixnum
       property  :grn_type__c, String
       property  :grower_transaction_fee__c, Fixnum
       property  :if_trust_who_is_trustee__c, String
       property  :if_trader_what_type__c, String
       property  :merchant_organisation__c, String
       property  :observer_status_changed_to_buyer__c, Boolean
       property  :ok_back_from_d_b__c, String
       property  :registration_type__c, String
       property  :relationship_to_clear__c, String
       property  :rough_guide_to_grain_volume_mt__c, Fixnum
       property  :signed_schedule_1_returned__c, Boolean
       property  :what_grains_do_you_trade_in__c, String
       property  :per_mt__c, Fixnum

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :master_record_id, String
       property  :owner_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :bhc_used_for_grower_delivery__r, :class_name => 'Account', :child_key => [:bhc_used_for_grower_delivery__r_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :master_record, :class_name => 'Account', :child_key => [:master_record_id] #Reference : Account
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Account', :child_key => [:parent_id] #Reference : Account

       #Has many relationships - May need configuration
       has n,  :account_contact_roles
       has n,  :account_partners_from
       has n,  :account_partners_to
       has n,  :activity_histories
       has n,  :assets
       has n,  :attachments
       has n,  :cases
       has n,  :contacts
       has n,  :contracts
       has n,  :events
       has n,  :histories
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :opportunities
       has n,  :opportunity_partners_to
       has n,  :organisations__r
       has n,  :partners_from
       has n,  :partners_to
       has n,  :process_instances
       has n,  :process_steps
       has n,  :registrations1__r
       has n,  :registrations__r
       has n,  :shares
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def bhc_used_for_grower_delivery; Account.get(self.bhc_used_for_grower_delivery__c); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def master_record; Account.get(self.master_record_id); end
       def owner; User.get(self.owner_id); end
       def parent; Account.get(self.parent_id); end
    end

    class AccountContactRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class AccountHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :created_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
    end

    class AccountPartner
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_from_id, String
       property  :account_to_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String
       property  :reverse_partner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account_from, :class_name => 'Account', :child_key => [:account_from_id] #Reference : Account
       #belongs_to  :account_to, :class_name => 'Account', :child_key => [:account_to_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account_from; Account.get(self.account_from_id); end
       def account_to; Account.get(self.account_to_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class AccountShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :account_access_level, String
       property  :case_access_level, String
       property  :contact_access_level, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :opportunity_access_level, String
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :last_modified_by_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class AdditionalNumber
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :phone, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :call_center_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Asset
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :install_date, Date
       property  :is_competitor_product, Boolean
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :price, Fixnum
       property  :purchase_date, Date
       property  :quantity, Fixnum
       property  :serial_number, String
       property  :status, String
       property  :system_modstamp, DateTime
       property  :usage_end_date, Date

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :product2_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :product2, :class_name => 'Product2', :child_key => [:product2_id] #Reference : Product2

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :attachments
       has n,  :cases
       has n,  :events
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def product2; Product2.get(self.product2_id); end
    end

    class AssignmentRule
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :active, Boolean
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :name, String
       property  :sobject_type, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Attachment
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :body_length, Integer
       property  :content_type, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_private, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name
       #belongs_to  :last_modified_by, :class_name => 'Name', :child_key => [:last_modified_by_id] #Reference : Name
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :parent, :class_name => 'Name', :child_key => [:parent_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id) || Lead.get(self.last_modified_by_id) || Account.get(self.last_modified_by_id) || Contact.get(self.last_modified_by_id) || Opportunity.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def parent; User.get(self.parent_id) || Lead.get(self.parent_id) || Account.get(self.parent_id) || Contact.get(self.parent_id) || Opportunity.get(self.parent_id); end
    end

    class BrandTemplate
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :developer_name, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :system_modstamp, DateTime
       property  :value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class BusinessProcess
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime
       property  :table_enum_or_id, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CallCenter
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :internal_name, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Campaign
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :actual_cost, Fixnum
       property  :amount_all_opportunities, Fixnum
       property  :amount_won_opportunities, Fixnum
       property  :budgeted_cost, Fixnum
       property  :created_date, DateTime
       property  :description, String
       property  :end_date, Date
       property  :expected_response, Fixnum
       property  :expected_revenue, Fixnum
       property  :is_active, Boolean
       property  :is_deleted, Boolean
       property  :last_activity_date, Date
       property  :last_modified_date, DateTime
       property  :name, String
       property  :number_of_contacts, Integer
       property  :number_of_converted_leads, Integer
       property  :number_of_leads, Integer
       property  :number_of_opportunities, Integer
       property  :number_of_responses, Integer
       property  :number_of_won_opportunities, Integer
       property  :number_sent, Fixnum
       property  :start_date, Date
       property  :status, String
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Campaign', :child_key => [:parent_id] #Reference : Campaign

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :attachments
       has n,  :campaign_members
       has n,  :child_campaigns
       has n,  :events
       has n,  :leads
       has n,  :open_activities
       has n,  :opportunities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :shares
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
       def parent; Campaign.get(self.parent_id); end
    end

    class CampaignMember
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :first_responded_date, Date
       property  :has_responded, Boolean
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :status, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :campaign_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :lead_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :campaign, :class_name => 'Campaign', :child_key => [:campaign_id] #Reference : Campaign
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :lead, :class_name => 'Lead', :child_key => [:lead_id] #Reference : Lead

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def campaign; Campaign.get(self.campaign_id); end
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def lead; Lead.get(self.lead_id); end
    end

    class CampaignMemberStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :has_responded, Boolean
       property  :is_default, Boolean
       property  :is_deleted, Boolean
       property  :label, String
       property  :last_modified_date, DateTime
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :campaign_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CampaignShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :campaign_access_level, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :campaign_id, String
       property  :last_modified_by_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :campaign, :class_name => 'Campaign', :child_key => [:campaign_id] #Reference : Campaign
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def campaign; Campaign.get(self.campaign_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Case
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :case_number, String
       property  :closed_date, DateTime
       property  :created_date, DateTime
       property  :description, String
       property  :has_comments_unread_by_owner, Boolean
       property  :has_self_service_comments, Boolean
       property  :is_closed, Boolean
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :origin, String
       property  :priority, String
       property  :reason, String
       property  :status, String
       property  :subject, String
       property  :supplied_company, String
       property  :supplied_email, String
       property  :supplied_name, String
       property  :supplied_phone, String
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :attachments
       has n,  :case_comments
       has n,  :case_contact_roles
       has n,  :case_solutions
       has n,  :cases
       has n,  :events
       has n,  :histories
       has n,  :open_activities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :shares
       has n,  :solutions
       has n,  :tasks
       has n,  :team_members
       has n,  :team_template_records

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
    end

    class CaseComment
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :comment_body, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_published, Boolean
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name
       #belongs_to  :last_modified_by, :class_name => 'Name', :child_key => [:last_modified_by_id] #Reference : Name
       #belongs_to  :parent, :class_name => 'Case', :child_key => [:parent_id] #Reference : Case

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id) || Lead.get(self.last_modified_by_id) || Account.get(self.last_modified_by_id) || Contact.get(self.last_modified_by_id) || Opportunity.get(self.last_modified_by_id); end
       def parent; Case.get(self.parent_id); end
    end

    class CaseContactRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :cases_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :cases, :class_name => 'Case', :child_key => [:cases_id] #Reference : Case
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def cases; Case.get(self.cases_id); end
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :case_id, String
       property  :created_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :case, :class_name => 'Case', :child_key => [:case_id] #Reference : Case
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def case; Case.get(self.case_id); end
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
    end

    class CaseShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :case_access_level, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :case_id, String
       property  :last_modified_by_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :case, :class_name => 'Case', :child_key => [:case_id] #Reference : Case
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def case; Case.get(self.case_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseSolution
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :case_id, String
       property  :created_by_id, String
       property  :solution_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :case, :class_name => 'Case', :child_key => [:case_id] #Reference : Case
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :solution, :class_name => 'Solution', :child_key => [:solution_id] #Reference : Solution

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def case; Case.get(self.case_id); end
       def created_by; User.get(self.created_by_id); end
       def solution; Solution.get(self.solution_id); end
    end

    class CaseStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_closed, Boolean
       property  :is_default, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseTeamMember
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :member_id, String
       property  :parent_id, String
       property  :team_role_id, String
       property  :team_template_member_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Case', :child_key => [:parent_id] #Reference : Case

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def parent; Case.get(self.parent_id); end
    end

    class CaseTeamRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :access_level, String
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :name, String
       property  :preferences_visible_in_csp, Boolean
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseTeamTemplate
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseTeamTemplateMember
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :member_id, String
       property  :team_role_id, String
       property  :team_template_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CaseTeamTemplateRecord
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :parent_id, String
       property  :team_template_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Case', :child_key => [:parent_id] #Reference : Case

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def parent; Case.get(self.parent_id); end
    end

    class CategoryData
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :category_node_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :related_sobject_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class CategoryNode
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :sort_style, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Community
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Contact
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :assistant_name, String
       property  :assistant_phone, String
       property  :birthdate, Date
       property  :created_date, DateTime
       property  :department, String
       property  :description, String
       property  :email, String
       property  :email_bounced_date, DateTime
       property  :email_bounced_reason, String
       property  :fax, String
       property  :first_name, String
       property  :home_phone, String
       property  :is_deleted, Boolean
       property  :last_activity_date, Date
       property  :last_cu_request_date, DateTime
       property  :last_cu_update_date, DateTime
       property  :last_modified_date, DateTime
       property  :last_name, String
       property  :lead_source, String
       property  :mailing_city, String
       property  :mailing_country, String
       property  :mailing_postal_code, String
       property  :mailing_state, String
       property  :mailing_street, String
       property  :mobile_phone, String
       property  :name, String
       property  :other_city, String
       property  :other_country, String
       property  :other_phone, String
       property  :other_postal_code, String
       property  :other_state, String
       property  :other_street, String
       property  :phone, String
       property  :salutation, String
       property  :system_modstamp, DateTime
       property  :title, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :master_record_id, String
       property  :owner_id, String
       property  :reports_to_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :master_record, :class_name => 'Contact', :child_key => [:master_record_id] #Reference : Contact
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User
       #belongs_to  :reports_to, :class_name => 'Contact', :child_key => [:reports_to_id] #Reference : Contact

       #Has many relationships - May need configuration
       has n,  :account_contact_roles
       has n,  :activity_histories
       has n,  :assets
       has n,  :attachments
       has n,  :campaign_members
       has n,  :case_contact_roles
       has n,  :cases
       has n,  :contract_contact_roles
       has n,  :contracts_signed
       has n,  :email_statuses
       has n,  :events
       has n,  :histories
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :opportunities
       has n,  :opportunity_contact_roles
       has n,  :process_instances
       has n,  :process_steps
       has n,  :shares
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def master_record; Contact.get(self.master_record_id); end
       def owner; User.get(self.owner_id); end
       def reports_to; Contact.get(self.reports_to_id); end
    end

    class ContactHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contact_id, String
       property  :created_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
    end

    class ContactShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :contact_access_level, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contact_id, String
       property  :last_modified_by_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contact; Contact.get(self.contact_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Contract
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :activated_date, DateTime
       property  :billing_city, String
       property  :billing_country, String
       property  :billing_postal_code, String
       property  :billing_state, String
       property  :billing_street, String
       property  :company_signed_date, Date
       property  :contract_number, String
       property  :contract_term, Integer
       property  :created_date, DateTime
       property  :customer_signed_date, Date
       property  :customer_signed_title, String
       property  :description, String
       property  :end_date, Date
       property  :is_deleted, Boolean
       property  :last_activity_date, Date
       property  :last_approved_date, DateTime
       property  :last_modified_date, DateTime
       property  :owner_expiration_notice, String
       property  :shipping_city, String
       property  :shipping_country, String
       property  :shipping_postal_code, String
       property  :shipping_state, String
       property  :shipping_street, String
       property  :special_terms, String
       property  :start_date, Date
       property  :status, String
       property  :status_code, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :activated_by_id, String
       property  :company_signed_id, String
       property  :created_by_id, String
       property  :customer_signed_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :activated_by, :class_name => 'User', :child_key => [:activated_by_id] #Reference : User
       #belongs_to  :company_signed, :class_name => 'User', :child_key => [:company_signed_id] #Reference : User
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :customer_signed, :class_name => 'Contact', :child_key => [:customer_signed_id] #Reference : Contact
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :approvals
       has n,  :attachments
       has n,  :contract_contact_roles
       has n,  :events
       has n,  :histories
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def activated_by; User.get(self.activated_by_id); end
       def company_signed; User.get(self.company_signed_id); end
       def created_by; User.get(self.created_by_id); end
       def customer_signed; Contact.get(self.customer_signed_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
    end

    class ContractContactRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contact_id, String
       property  :contract_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :contract, :class_name => 'Contract', :child_key => [:contract_id] #Reference : Contract
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contact; Contact.get(self.contact_id); end
       def contract; Contract.get(self.contract_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class ContractHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contract_id, String
       property  :created_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contract, :class_name => 'Contract', :child_key => [:contract_id] #Reference : Contract
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contract; Contract.get(self.contract_id); end
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
    end

    class ContractStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_default, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :status_code, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Document
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :body_length, Integer
       property  :content_type, String
       property  :created_date, DateTime
       property  :description, String
       property  :developer_name, String
       property  :is_body_searchable, Boolean
       property  :is_deleted, Boolean
       property  :is_internal_use_only, Boolean
       property  :is_public, Boolean
       property  :keywords, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :system_modstamp, DateTime
       property  :type, String
       property  :url, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :author_id, String
       property  :created_by_id, String
       property  :folder_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :author, :class_name => 'User', :child_key => [:author_id] #Reference : User
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :folder, :class_name => 'Folder', :child_key => [:folder_id] #Reference : Folder
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def author; User.get(self.author_id); end
       def created_by; User.get(self.created_by_id); end
       def folder; Folder.get(self.folder_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class DocumentAttachmentMap
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :document_sequence, Integer

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :document_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
    end

    class EmailServicesAddress
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :authorized_senders, String
       property  :created_date, DateTime
       property  :email_domain_name, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :local_part, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :function_id, String
       property  :last_modified_by_id, String
       property  :run_as_user_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :function, :class_name => 'EmailServicesFunction', :child_key => [:function_id] #Reference : EmailServicesFunction
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def function; EmailServicesFunction.get(self.function_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class EmailServicesFunction
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :address_inactive_action, String
       property  :attachment_option, String
       property  :authentication_failure_action, String
       property  :authorization_failure_action, String
       property  :authorized_senders, String
       property  :created_date, DateTime
       property  :function_inactive_action, String
       property  :function_name, String
       property  :is_active, Boolean
       property  :is_authentication_required, Boolean
       property  :is_tls_required, Boolean
       property  :last_modified_date, DateTime
       property  :over_limit_action, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :apex_class_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :addresses

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class EmailTemplate
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :api_version, Fixnum
       property  :body, String
       property  :created_date, DateTime
       property  :description, String
       property  :developer_name, String
       property  :encoding, String
       property  :html_value, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :last_used_date, DateTime
       property  :markup, String
       property  :name, String
       property  :namespace_prefix, String
       property  :subject, String
       property  :system_modstamp, DateTime
       property  :template_style, String
       property  :template_type, String
       property  :times_used, Integer

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :brand_template_id, String
       property  :created_by_id, String
       property  :folder_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :folder, :class_name => 'Folder', :child_key => [:folder_id] #Reference : Folder
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :attachments

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def folder; Folder.get(self.folder_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
    end

    class Event
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :activity_date, Date
       property  :activity_date_time, DateTime
       property  :created_date, DateTime
       property  :description, String
       property  :duration_in_minutes, Integer
       property  :end_date_time, DateTime
       property  :is_all_day_event, Boolean
       property  :is_archived, Boolean
       property  :is_child, Boolean
       property  :is_deleted, Boolean
       property  :is_group_event, Boolean
       property  :is_private, Boolean
       property  :is_recurrence, Boolean
       property  :is_reminder_set, Boolean
       property  :last_modified_date, DateTime
       property  :location, String
       property  :recurrence_day_of_month, Integer
       property  :recurrence_day_of_week_mask, Integer
       property  :recurrence_end_date_only, Date
       property  :recurrence_instance, String
       property  :recurrence_interval, Integer
       property  :recurrence_month_of_year, String
       property  :recurrence_start_date_time, DateTime
       property  :recurrence_time_zone_sid_key, String
       property  :recurrence_type, String
       property  :reminder_date_time, DateTime
       property  :show_as, String
       property  :start_date_time, DateTime
       property  :subject, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :recurrence_activity_id, String
       property  :what_id, String
       property  :who_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :what, :class_name => 'Name', :child_key => [:what_id] #Reference : Name
       #belongs_to  :who, :class_name => 'Name', :child_key => [:who_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :event_attendees
       has n,  :recurring_events

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def what; User.get(self.what_id) || Lead.get(self.what_id) || Account.get(self.what_id) || Contact.get(self.what_id) || Opportunity.get(self.what_id); end
       def who; User.get(self.who_id) || Lead.get(self.who_id) || Account.get(self.who_id) || Contact.get(self.who_id) || Opportunity.get(self.who_id); end
    end

    class EventAttendee
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :responded_date, DateTime
       property  :response, String
       property  :status, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :attendee_id, String
       property  :created_by_id, String
       property  :event_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :attendee, :class_name => 'Name', :child_key => [:attendee_id] #Reference : Name
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :event, :class_name => 'Event', :child_key => [:event_id] #Reference : Event
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def attendee; User.get(self.attendee_id) || Lead.get(self.attendee_id) || Account.get(self.attendee_id) || Contact.get(self.attendee_id) || Opportunity.get(self.attendee_id); end
       def created_by; User.get(self.created_by_id); end
       def event; Event.get(self.event_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class FiscalYearSettings
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :description, String
       property  :end_date, Date
       property  :is_standard_year, Boolean
       property  :name, String
       property  :period_label_scheme, String
       property  :period_prefix, String
       property  :quarter_label_scheme, String
       property  :quarter_prefix, String
       property  :start_date, Date
       property  :system_modstamp, DateTime
       property  :week_label_scheme, String
       property  :week_start_day, Integer
       property  :year_type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :period_id, String

       #Has many relationships - May need configuration
       has n,  :periods
    end

    class Folder
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :access_type, String
       property  :created_date, DateTime
       property  :developer_name, String
       property  :is_readonly, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class ForecastShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :access_level, String
       property  :can_submit, Boolean
       property  :last_modified_date, DateTime
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :last_modified_by_id, String
       property  :user_or_group_id, String
       property  :user_role_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Group
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :does_send_email_to_members, Boolean
       property  :email, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :related_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :delegated_users
       has n,  :group_members
       has n,  :queue_sobjects

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
    end

    class GroupMember
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :group_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :group, :class_name => 'Group', :child_key => [:group_id] #Reference : Group

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def group; Group.get(self.group_id); end
    end

    class Holiday
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :activity_date, Date
       property  :created_date, DateTime
       property  :description, String
       property  :end_time_in_minutes, Integer
       property  :is_all_day, Boolean
       property  :is_recurrence, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :recurrence_day_of_month, Integer
       property  :recurrence_day_of_week_mask, Integer
       property  :recurrence_end_date_only, Date
       property  :recurrence_instance, String
       property  :recurrence_interval, Integer
       property  :recurrence_month_of_year, String
       property  :recurrence_start_date, Date
       property  :recurrence_type, String
       property  :start_time_in_minutes, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Idea
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :categories, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_html, Boolean
       property  :is_locked, Boolean
       property  :last_comment_date, DateTime
       property  :last_modified_date, DateTime
       property  :num_comments, Integer
       property  :status, String
       property  :system_modstamp, DateTime
       property  :title, String
       property  :vote_score, Fixnum
       property  :vote_total, Fixnum

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :community_id, String
       property  :created_by_id, String
       property  :last_comment_id, String
       property  :last_modified_by_id, String
       property  :parent_idea_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :community, :class_name => 'Community', :child_key => [:community_id] #Reference : Community
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_comment, :class_name => 'IdeaComment', :child_key => [:last_comment_id] #Reference : IdeaComment
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :comments
       has n,  :votes

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def community; Community.get(self.community_id); end
       def created_by; User.get(self.created_by_id); end
       def last_comment; IdeaComment.get(self.last_comment_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class IdeaComment
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :comment_body, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_html, Boolean
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :idea_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :idea, :class_name => 'Idea', :child_key => [:idea_id] #Reference : Idea

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def idea; Idea.get(self.idea_id); end
    end

    class Lead
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :annual_revenue, Fixnum
       property  :city, String
       property  :company, String
       property  :converted_date, Date
       property  :country, String
       property  :created_date, DateTime
       property  :description, String
       property  :email, String
       property  :email_bounced_date, DateTime
       property  :email_bounced_reason, String
       property  :first_name, String
       property  :industry, String
       property  :is_converted, Boolean
       property  :is_deleted, Boolean
       property  :is_unread_by_owner, Boolean
       property  :last_activity_date, Date
       property  :last_modified_date, DateTime
       property  :last_name, String
       property  :lead_source, String
       property  :mobile_phone, String
       property  :name, String
       property  :number_of_employees, Integer
       property  :phone, String
       property  :postal_code, String
       property  :rating, String
       property  :salutation, String
       property  :state, String
       property  :status, String
       property  :street, String
       property  :system_modstamp, DateTime
       property  :title, String
       property  :website, String

       #Custom fields for CLEAR version of SalesForce 
       property  :abn__c, Fixnum
       property  :abn_sent_to_d_b__c, Boolean
       property  :acn__c, Fixnum
       property  :accounts_created_for_all_team_members__c, Boolean
       property  :application_pack_sent__c, Boolean
       property  :bhc_used_for_grower_delivery__c, String
       property  :bulk_grower_list_returned__c, Boolean
       property  :company_trading_diagram_finalised__c, Boolean
       property  :d_b_report_ordered_on__c, Date
       property  :d_b_report_returned_on__c, Date
       property  :estimated_grain_volume_in_08_09__c, Fixnum
       property  :estimated_growers_to_service_in_08_09__c, Fixnum
       property  :fax__c, String
       property  :grn_number__c, Fixnum
       property  :grn_type__c, String
       property  :grower_transaction_fee__c, Fixnum
       property  :growers_broker__c, String
       property  :if_growers_broker_is_not_clear_user__c, String
       property  :if_trust_who_is_trustee__c, String
       property  :if_trader_what_type__c, String
       property  :merchant_organisation__c, String
       property  :mobile__c, String
       property  :observer_account_created__c, Boolean
       property  :observer_account_requested__c, Boolean
       property  :observer_status_changed_to_buyer__c, Boolean
       property  :ok_back_from_d_b__c, String
       property  :registration_type__c, String
       property  :rough_guide_to_grain_volume_mt__c, Fixnum
       property  :signed_schedule_1_returned__c, Boolean
       property  :waiting_on_call_back__c, Boolean
       property  :what_grains_do_you_trade_in__c, String
       property  :feedback__c, String
       property  :per_mt__c, Fixnum

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :converted_account_id, String
       property  :converted_contact_id, String
       property  :converted_opportunity_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :master_record_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :bhc_used_for_grower_delivery__r, :class_name => 'Account', :child_key => [:bhc_used_for_grower_delivery__r_id] #Reference : Account
       #belongs_to  :campaign, :class_name => 'Campaign', :child_key => [:campaign_id] #Reference : Campaign
       #belongs_to  :converted_account, :class_name => 'Account', :child_key => [:converted_account_id] #Reference : Account
       #belongs_to  :converted_contact, :class_name => 'Contact', :child_key => [:converted_contact_id] #Reference : Contact
       #belongs_to  :converted_opportunity, :class_name => 'Opportunity', :child_key => [:converted_opportunity_id] #Reference : Opportunity
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :growers_broker__r, :class_name => 'Account', :child_key => [:growers_broker__r_id] #Reference : Account
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :master_record, :class_name => 'Lead', :child_key => [:master_record_id] #Reference : Lead
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :attachments
       has n,  :campaign_members
       has n,  :email_statuses
       has n,  :events
       has n,  :histories
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :sfga__r00_n40000001_hggq_eac__r
       has n,  :sfga__r00_n40000001_hggv_eac__r
       has n,  :sfga__r00_n40000001_hgh4_eac__r
       has n,  :sfga__r00_n40000001_hgh9_eac__r
       has n,  :sfga__r00_n40000001_hgh_feas__r
       has n,  :shares
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def bhc_used_for_grower_delivery; Account.get(self.bhc_used_for_grower_delivery__c); end
       def campaign; Campaign.get(self.campaign_id); end
       def converted_account; Account.get(self.converted_account_id); end
       def converted_contact; Contact.get(self.converted_contact_id); end
       def converted_opportunity; Opportunity.get(self.converted_opportunity_id); end
       def created_by; User.get(self.created_by_id); end
       def growers_broker; Account.get(self.growers_broker__c); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def master_record; Lead.get(self.master_record_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
    end

    class LeadHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :lead_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name
       #belongs_to  :lead, :class_name => 'Lead', :child_key => [:lead_id] #Reference : Lead

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
       def lead; Lead.get(self.lead_id); end
    end

    class LeadShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :lead_access_level, String
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :last_modified_by_id, String
       property  :lead_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :lead, :class_name => 'Lead', :child_key => [:lead_id] #Reference : Lead

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def last_modified_by; User.get(self.last_modified_by_id); end
       def lead; Lead.get(self.lead_id); end
    end

    class LeadStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_converted, Boolean
       property  :is_default, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class MailmergeTemplate
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :body_length, Integer
       property  :created_date, DateTime
       property  :description, String
       property  :filename, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :last_used_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Name
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :email, String
       property  :first_name, String
       property  :is_active, Boolean
       property  :last_name, String
       property  :name, String
       property  :phone, String
       property  :title, String
       property  :type, String
       property  :username, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :profile_id, String
       property  :user_role_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :profile, :class_name => 'Profile', :child_key => [:profile_id] #Reference : Profile
       #belongs_to  :user_role, :class_name => 'UserRole', :child_key => [:user_role_id] #Reference : UserRole

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def profile; Profile.get(self.profile_id); end
       def user_role; UserRole.get(self.user_role_id); end
    end

    class Note
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_private, Boolean
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime
       property  :title, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Name', :child_key => [:parent_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
       def parent; User.get(self.parent_id) || Lead.get(self.parent_id) || Account.get(self.parent_id) || Contact.get(self.parent_id) || Opportunity.get(self.parent_id); end
    end

    class Opportunity
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :amount, Fixnum
       property  :close_date, Date
       property  :created_date, DateTime
       property  :description, String
       property  :fiscal, String
       property  :fiscal_quarter, Integer
       property  :fiscal_year, Integer
       property  :forecast_category, String
       property  :forecast_category_name, String
       property  :has_opportunity_line_item, Boolean
       property  :is_closed, Boolean
       property  :is_deleted, Boolean
       property  :is_won, Boolean
       property  :last_activity_date, Date
       property  :last_modified_date, DateTime
       property  :lead_source, String
       property  :name, String
       property  :next_step, String
       property  :probability, Fixnum
       property  :stage_name, String
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :pricebook2_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User
       #belongs_to  :pricebook2, :class_name => 'Pricebook2', :child_key => [:pricebook2_id] #Reference : Pricebook2

       #Has many relationships - May need configuration
       has n,  :account_partners
       has n,  :activity_histories
       has n,  :attachments
       has n,  :events
       has n,  :histories
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :opportunity_competitors
       has n,  :opportunity_contact_roles
       has n,  :opportunity_histories
       has n,  :opportunity_line_items
       has n,  :opportunity_partners_from
       has n,  :partners
       has n,  :process_instances
       has n,  :process_steps
       has n,  :sfga__r00_n40000001_hggr_eac__r
       has n,  :sfga__r00_n40000001_hggw_eac__r
       has n,  :sfga__r00_n40000001_hgh5_eac__r
       has n,  :sfga__r00_n40000001_hgh_aeas__r
       has n,  :sfga__r00_n40000001_hgh_eeas__r
       has n,  :shares
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
       def pricebook2; Pricebook2.get(self.pricebook2_id); end
    end

    class OpportunityCompetitor
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :competitor_name, String
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :strengths, String
       property  :system_modstamp, DateTime
       property  :weaknesses, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityContactRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityFieldHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :opportunity_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :amount, Fixnum
       property  :close_date, Date
       property  :created_date, DateTime
       property  :expected_revenue, Fixnum
       property  :forecast_category, String
       property  :is_deleted, Boolean
       property  :probability, Fixnum
       property  :stage_name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :opportunity_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityLineItem
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :list_price, Fixnum
       property  :quantity, Fixnum
       property  :service_date, Date
       property  :sort_order, Integer
       property  :system_modstamp, DateTime
       property  :total_price, Fixnum
       property  :unit_price, Fixnum

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String
       property  :pricebook_entry_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity
       #belongs_to  :pricebook_entry, :class_name => 'PricebookEntry', :child_key => [:pricebook_entry_id] #Reference : PricebookEntry

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
       def pricebook_entry; PricebookEntry.get(self.pricebook_entry_id); end
    end

    class OpportunityPartner
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_to_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String
       property  :reverse_partner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account_to, :class_name => 'Account', :child_key => [:account_to_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account_to; Account.get(self.account_to_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityShare
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :opportunity_access_level, String
       property  :row_cause, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :last_modified_by_id, String
       property  :opportunity_id, String
       property  :user_or_group_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class OpportunityStage
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :default_probability, Fixnum
       property  :description, String
       property  :forecast_category, String
       property  :forecast_category_name, String
       property  :is_active, Boolean
       property  :is_closed, Boolean
       property  :is_won, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class OrgWideEmailAddress
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :address, String
       property  :created_date, DateTime
       property  :display_name, String
       property  :is_allow_all_profiles, Boolean
       property  :last_modified_date, DateTime
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Organization
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :city, String
       property  :compliance_bcc_email, String
       property  :country, String
       property  :created_date, DateTime
       property  :default_account_access, String
       property  :default_calendar_access, String
       property  :default_campaign_access, String
       property  :default_case_access, String
       property  :default_contact_access, String
       property  :default_lead_access, String
       property  :default_locale_sid_key, String
       property  :default_opportunity_access, String
       property  :default_pricebook_access, String
       property  :division, String
       property  :fax, String
       property  :fiscal_year_start_month, Integer
       property  :language_locale_key, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :organization_type, String
       property  :phone, String
       property  :postal_code, String
       property  :preferences_require_opportunity_products, Boolean
       property  :primary_contact, String
       property  :receives_admin_info_emails, Boolean
       property  :receives_info_emails, Boolean
       property  :state, String
       property  :street, String
       property  :system_modstamp, DateTime
       property  :trial_expiration_date, DateTime
       property  :ui_skin, String
       property  :uses_start_date_as_fiscal_year_name, Boolean
       property  :web_to_case_default_origin, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Partner
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_primary, Boolean
       property  :last_modified_date, DateTime
       property  :role, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_from_id, String
       property  :account_to_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :opportunity_id, String
       property  :reverse_partner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account_from, :class_name => 'Account', :child_key => [:account_from_id] #Reference : Account
       #belongs_to  :account_to, :class_name => 'Account', :child_key => [:account_to_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :opportunity, :class_name => 'Opportunity', :child_key => [:opportunity_id] #Reference : Opportunity

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account_from; Account.get(self.account_from_id); end
       def account_to; Account.get(self.account_to_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def opportunity; Opportunity.get(self.opportunity_id); end
    end

    class PartnerRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :reverse_role, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Period
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :end_date, Date
       property  :is_forecast_period, Boolean
       property  :number, Integer
       property  :period_label, String
       property  :quarter_label, String
       property  :start_date, Date
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :fiscal_year_settings_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :fiscal_year_settings, :class_name => 'FiscalYearSettings', :child_key => [:fiscal_year_settings_id] #Reference : FiscalYearSettings

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def fiscal_year_settings; FiscalYearSettings.get(self.fiscal_year_settings_id); end
    end

    class Pricebook2
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :is_active, Boolean
       property  :is_deleted, Boolean
       property  :is_standard, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :opportunities
       has n,  :pricebook_entries

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class PricebookEntry
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_active, Boolean
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :product_code, String
       property  :system_modstamp, DateTime
       property  :unit_price, Fixnum
       property  :use_standard_price, Boolean

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :pricebook2_id, String
       property  :product2_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :pricebook2, :class_name => 'Pricebook2', :child_key => [:pricebook2_id] #Reference : Pricebook2
       #belongs_to  :product2, :class_name => 'Product2', :child_key => [:product2_id] #Reference : Product2

       #Has many relationships - May need configuration
       has n,  :opportunity_line_items

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def pricebook2; Pricebook2.get(self.pricebook2_id); end
       def product2; Product2.get(self.product2_id); end
    end

    class ProcessInstance
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :status, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :target_object_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :target_object, :class_name => 'Name', :child_key => [:target_object_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :steps
       has n,  :steps_and_workitems
       has n,  :workitems

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def target_object; User.get(self.target_object_id) || Lead.get(self.target_object_id) || Account.get(self.target_object_id) || Contact.get(self.target_object_id) || Opportunity.get(self.target_object_id); end
    end

    class ProcessInstanceStep
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :comments, String
       property  :created_date, DateTime
       property  :step_status, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :actor_id, String
       property  :created_by_id, String
       property  :original_actor_id, String
       property  :process_instance_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :actor, :class_name => 'Name', :child_key => [:actor_id] #Reference : Name
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :original_actor, :class_name => 'Name', :child_key => [:original_actor_id] #Reference : Name
       #belongs_to  :process_instance, :class_name => 'ProcessInstance', :child_key => [:process_instance_id] #Reference : ProcessInstance

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def actor; User.get(self.actor_id) || Lead.get(self.actor_id) || Account.get(self.actor_id) || Contact.get(self.actor_id) || Opportunity.get(self.actor_id); end
       def created_by; User.get(self.created_by_id); end
       def original_actor; User.get(self.original_actor_id) || Lead.get(self.original_actor_id) || Account.get(self.original_actor_id) || Contact.get(self.original_actor_id) || Opportunity.get(self.original_actor_id); end
       def process_instance; ProcessInstance.get(self.process_instance_id); end
    end

    class ProcessInstanceWorkitem
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :actor_id, String
       property  :created_by_id, String
       property  :original_actor_id, String
       property  :process_instance_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :actor, :class_name => 'Name', :child_key => [:actor_id] #Reference : Name
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :original_actor, :class_name => 'Name', :child_key => [:original_actor_id] #Reference : Name
       #belongs_to  :process_instance, :class_name => 'ProcessInstance', :child_key => [:process_instance_id] #Reference : ProcessInstance

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def actor; User.get(self.actor_id) || Lead.get(self.actor_id) || Account.get(self.actor_id) || Contact.get(self.actor_id) || Opportunity.get(self.actor_id); end
       def created_by; User.get(self.created_by_id); end
       def original_actor; User.get(self.original_actor_id) || Lead.get(self.original_actor_id) || Account.get(self.original_actor_id) || Contact.get(self.original_actor_id) || Opportunity.get(self.original_actor_id); end
       def process_instance; ProcessInstance.get(self.process_instance_id); end
    end

    class Product2
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :family, String
       property  :is_active, Boolean
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :product_code, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :assets
       has n,  :attachments
       has n,  :events
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :open_activities
       has n,  :opportunity_line_items
       has n,  :pricebook_entries
       has n,  :process_instances
       has n,  :process_steps
       has n,  :tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Profile
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :permissions_api_enabled, Boolean
       property  :permissions_api_user_only, Boolean
       property  :permissions_author_apex, Boolean
       property  :permissions_convert_leads, Boolean
       property  :permissions_create_multiforce, Boolean
       property  :permissions_custom_sidebar_on_all_pages, Boolean
       property  :permissions_customize_application, Boolean
       property  :permissions_disable_notifications, Boolean
       property  :permissions_edit_case_comments, Boolean
       property  :permissions_edit_event, Boolean
       property  :permissions_edit_opp_line_item_unit_price, Boolean
       property  :permissions_edit_public_documents, Boolean
       property  :permissions_edit_readonly_fields, Boolean
       property  :permissions_edit_reports, Boolean
       property  :permissions_edit_task, Boolean
       property  :permissions_import_leads, Boolean
       property  :permissions_install_multiforce, Boolean
       property  :permissions_manage_analytic_snapshots, Boolean
       property  :permissions_manage_business_hour_holidays, Boolean
       property  :permissions_manage_call_centers, Boolean
       property  :permissions_manage_cases, Boolean
       property  :permissions_manage_categories, Boolean
       property  :permissions_manage_css_users, Boolean
       property  :permissions_manage_custom_report_types, Boolean
       property  :permissions_manage_dashboards, Boolean
       property  :permissions_manage_leads, Boolean
       property  :permissions_manage_mobile, Boolean
       property  :permissions_manage_self_service, Boolean
       property  :permissions_manage_solutions, Boolean
       property  :permissions_manage_users, Boolean
       property  :permissions_modify_all_data, Boolean
       property  :permissions_password_never_expires, Boolean
       property  :permissions_publish_multiforce, Boolean
       property  :permissions_run_reports, Boolean
       property  :permissions_schedule_job, Boolean
       property  :permissions_schedule_reports, Boolean
       property  :permissions_send_sit_requests, Boolean
       property  :permissions_solution_import, Boolean
       property  :permissions_transfer_any_case, Boolean
       property  :permissions_transfer_any_entity, Boolean
       property  :permissions_transfer_any_lead, Boolean
       property  :permissions_use_team_reassign_wizards, Boolean
       property  :permissions_view_all_data, Boolean
       property  :permissions_view_setup, Boolean
       property  :system_modstamp, DateTime
       property  :user_type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :user_license_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :user_license, :class_name => 'UserLicense', :child_key => [:user_license_id] #Reference : UserLicense

       #Has many relationships - May need configuration
       has n,  :users

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def user_license; UserLicense.get(self.user_license_id); end
    end

    class QueueSobject
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :sobject_type, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :queue_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :queue, :class_name => 'Group', :child_key => [:queue_id] #Reference : Group

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def queue; Group.get(self.queue_id); end
    end

    class RecordType
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :developer_name, String
       property  :is_active, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :sobject_type, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :business_process_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class SFGA_AdGroup__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Custom fields for CLEAR version of SalesForce 
       property  :sfga__lead__c, String
       property  :sfga__opportunity__c, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :sfga__lead__r, :class_name => 'Lead', :child_key => [:sfga__lead__r_id] #Reference : Lead
       #belongs_to  :sfga__opportunity__r, :class_name => 'Opportunity', :child_key => [:sfga__opportunity__r_id] #Reference : Opportunity

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def sfga__lead; Lead.get(self.sfga__lead__c); end
       def sfga__opportunity; Opportunity.get(self.sfga__opportunity__c); end
    end

    class SFGA_GoogleCampaign__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Custom fields for CLEAR version of SalesForce 
       property  :sfga__google_campaign_description__c, String
       property  :sfga__lead__c, String
       property  :sfga__opportunity__c, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :sfga__lead__r, :class_name => 'Lead', :child_key => [:sfga__lead__r_id] #Reference : Lead
       #belongs_to  :sfga__opportunity__r, :class_name => 'Opportunity', :child_key => [:sfga__opportunity__r_id] #Reference : Opportunity

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def sfga__lead; Lead.get(self.sfga__lead__c); end
       def sfga__opportunity; Opportunity.get(self.sfga__opportunity__c); end
    end

    class SFGA_Keyword__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Custom fields for CLEAR version of SalesForce 
       property  :sfga__lead__c, String
       property  :sfga__opportunity__c, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :sfga__lead__r, :class_name => 'Lead', :child_key => [:sfga__lead__r_id] #Reference : Lead
       #belongs_to  :sfga__opportunity__r, :class_name => 'Opportunity', :child_key => [:sfga__opportunity__r_id] #Reference : Opportunity

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def sfga__lead; Lead.get(self.sfga__lead__c); end
       def sfga__opportunity; Opportunity.get(self.sfga__opportunity__c); end
    end

    class SFGA_SearchPhrase__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Custom fields for CLEAR version of SalesForce 
       property  :sfga__lead__c, String
       property  :sfga__opportunity__c, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :sfga__lead__r, :class_name => 'Lead', :child_key => [:sfga__lead__r_id] #Reference : Lead
       #belongs_to  :sfga__opportunity__r, :class_name => 'Opportunity', :child_key => [:sfga__opportunity__r_id] #Reference : Opportunity

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def sfga__lead; Lead.get(self.sfga__lead__c); end
       def sfga__opportunity; Opportunity.get(self.sfga__opportunity__c); end
    end

    class SFGA_TextAd__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Custom fields for CLEAR version of SalesForce 
       property  :sfga__lead__c, String
       property  :sfga__opportunity__c, String
       property  :sfga__text_ad_description_1__c, String
       property  :sfga__text_ad_description_2__c, String
       property  :sfga__text_ad_destination_url__c, String
       property  :sfga__text_ad_display_url__c, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :sfga__lead__r, :class_name => 'Lead', :child_key => [:sfga__lead__r_id] #Reference : Lead
       #belongs_to  :sfga__opportunity__r, :class_name => 'Opportunity', :child_key => [:sfga__opportunity__r_id] #Reference : Opportunity

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def sfga__lead; Lead.get(self.sfga__lead__c); end
       def sfga__opportunity; Opportunity.get(self.sfga__opportunity__c); end
    end

    class SFGA_Version3303__c
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :last_modified_date, DateTime
       property  :name, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :notes
       has n,  :notes_and_attachments
       has n,  :process_instances
       has n,  :process_steps

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
    end

    class Scontrol
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :binary, String
       property  :body_length, Integer
       property  :content_source, String
       property  :created_date, DateTime
       property  :description, String
       property  :developer_name, String
       property  :encoding_key, String
       property  :filename, String
       property  :html_wrapper, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :supports_caching, Boolean
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class SelfServiceUser
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :email, String
       property  :first_name, String
       property  :is_active, Boolean
       property  :language_locale_key, String
       property  :last_login_date, DateTime
       property  :last_modified_date, DateTime
       property  :last_name, String
       property  :locale_sid_key, String
       property  :name, String
       property  :super_user, Boolean
       property  :system_modstamp, DateTime
       property  :time_zone_sid_key, String
       property  :username, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :contact_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Solution
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :is_html, Boolean
       property  :is_published, Boolean
       property  :is_published_in_public_kb, Boolean
       property  :is_reviewed, Boolean
       property  :last_modified_date, DateTime
       property  :solution_name, String
       property  :solution_note, String
       property  :solution_number, String
       property  :status, String
       property  :system_modstamp, DateTime
       property  :times_used, Integer

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'User', :child_key => [:owner_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :activity_histories
       has n,  :attachments
       has n,  :case_solutions
       has n,  :events
       has n,  :histories
       has n,  :open_activities
       has n,  :process_instances
       has n,  :process_steps
       has n,  :tasks
       has n,  :votes

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id); end
    end

    class SolutionHistory
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :field, String
       property  :is_deleted, Boolean
       property  :new_value, String
       property  :old_value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :solution_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'Name', :child_key => [:created_by_id] #Reference : Name
       #belongs_to  :solution, :class_name => 'Solution', :child_key => [:solution_id] #Reference : Solution

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id) || Lead.get(self.created_by_id) || Account.get(self.created_by_id) || Contact.get(self.created_by_id) || Opportunity.get(self.created_by_id); end
       def solution; Solution.get(self.solution_id); end
    end

    class SolutionStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_default, Boolean
       property  :is_reviewed, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class StaticResource
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :body, String
       property  :body_length, Integer
       property  :cache_control, String
       property  :content_type, String
       property  :created_date, DateTime
       property  :description, String
       property  :last_modified_date, DateTime
       property  :name, String
       property  :namespace_prefix, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Task
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :activity_date, Date
       property  :call_disposition, String
       property  :call_duration_in_seconds, Integer
       property  :call_object, String
       property  :call_type, String
       property  :created_date, DateTime
       property  :description, String
       property  :is_archived, Boolean
       property  :is_closed, Boolean
       property  :is_deleted, Boolean
       property  :is_recurrence, Boolean
       property  :is_reminder_set, Boolean
       property  :last_modified_date, DateTime
       property  :priority, String
       property  :recurrence_day_of_month, Integer
       property  :recurrence_day_of_week_mask, Integer
       property  :recurrence_end_date_only, Date
       property  :recurrence_instance, String
       property  :recurrence_interval, Integer
       property  :recurrence_month_of_year, String
       property  :recurrence_start_date_only, Date
       property  :recurrence_time_zone_sid_key, String
       property  :recurrence_type, String
       property  :reminder_date_time, DateTime
       property  :status, String
       property  :subject, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :account_id, String
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :owner_id, String
       property  :recurrence_activity_id, String
       property  :what_id, String
       property  :who_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :account, :class_name => 'Account', :child_key => [:account_id] #Reference : Account
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :owner, :class_name => 'Name', :child_key => [:owner_id] #Reference : Name
       #belongs_to  :what, :class_name => 'Name', :child_key => [:what_id] #Reference : Name
       #belongs_to  :who, :class_name => 'Name', :child_key => [:who_id] #Reference : Name

       #Has many relationships - May need configuration
       has n,  :attachments
       has n,  :recurring_tasks

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def account; Account.get(self.account_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def owner; User.get(self.owner_id) || Lead.get(self.owner_id) || Account.get(self.owner_id) || Contact.get(self.owner_id) || Opportunity.get(self.owner_id); end
       def what; User.get(self.what_id) || Lead.get(self.what_id) || Account.get(self.what_id) || Contact.get(self.what_id) || Opportunity.get(self.what_id); end
       def who; User.get(self.who_id) || Lead.get(self.who_id) || Account.get(self.who_id) || Contact.get(self.who_id) || Opportunity.get(self.who_id); end
    end

    class TaskPriority
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_default, Boolean
       property  :is_high_priority, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class TaskStatus
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_closed, Boolean
       property  :is_default, Boolean
       property  :last_modified_date, DateTime
       property  :master_label, String
       property  :sort_order, Integer
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class User
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :city, String
       property  :community_nickname, String
       property  :company_name, String
       property  :country, String
       property  :created_date, DateTime
       property  :department, String
       property  :division, String
       property  :email, String
       property  :email_encoding_key, String
       property  :employee_number, String
       property  :extension, String
       property  :fax, String
       property  :first_name, String
       property  :forecast_enabled, Boolean
       property  :is_active, Boolean
       property  :language_locale_key, String
       property  :last_login_date, DateTime
       property  :last_modified_date, DateTime
       property  :last_name, String
       property  :locale_sid_key, String
       property  :mobile_phone, String
       property  :name, String
       property  :offline_pda_trial_expiration_date, DateTime
       property  :offline_trial_expiration_date, DateTime
       property  :phone, String
       property  :postal_code, String
       property  :receives_admin_info_emails, Boolean
       property  :receives_info_emails, Boolean
       property  :state, String
       property  :street, String
       property  :system_modstamp, DateTime
       property  :time_zone_sid_key, String
       property  :title, String
       property  :user_permissions_avantgo_user, Boolean
       property  :user_permissions_call_center_auto_login, Boolean
       property  :user_permissions_marketing_user, Boolean
       property  :user_permissions_mobile_user, Boolean
       property  :user_permissions_offline_user, Boolean
       property  :user_preferences_activity_reminders_popup, Boolean
       property  :user_preferences_apex_pages_developer_mode, Boolean
       property  :user_preferences_event_reminders_checkbox_default, Boolean
       property  :user_preferences_reminder_sound_off, Boolean
       property  :user_preferences_task_reminders_checkbox_default, Boolean
       property  :user_type, String
       property  :username, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :call_center_id, String
       property  :contact_id, String
       property  :created_by_id, String
       property  :delegated_approver_id, String
       property  :last_modified_by_id, String
       property  :manager_id, String
       property  :profile_id, String
       property  :user_role_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :contact, :class_name => 'Contact', :child_key => [:contact_id] #Reference : Contact
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User
       #belongs_to  :manager, :class_name => 'User', :child_key => [:manager_id] #Reference : User
       #belongs_to  :profile, :class_name => 'Profile', :child_key => [:profile_id] #Reference : Profile
       #belongs_to  :user_role, :class_name => 'UserRole', :child_key => [:user_role_id] #Reference : UserRole

       #Has many relationships - May need configuration
       has n,  :contracts_signed
       has n,  :delegated_users
       has n,  :user_preferences

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def contact; Contact.get(self.contact_id); end
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
       def manager; User.get(self.manager_id); end
       def profile; Profile.get(self.profile_id); end
       def user_role; UserRole.get(self.user_role_id); end
    end

    class UserLicense
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :license_definition_key, String
       property  :name, String
       property  :system_modstamp, DateTime
    end

    class UserPreference
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :preference, String
       property  :system_modstamp, DateTime
       property  :value, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :user_id, String
    end

    class UserRole
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :case_access_for_account_owner, String
       property  :contact_access_for_account_owner, String
       property  :last_modified_date, DateTime
       property  :may_forecast_manager_share, Boolean
       property  :name, String
       property  :opportunity_access_for_account_owner, String
       property  :portal_type, String
       property  :rollup_description, String
       property  :system_modstamp, DateTime

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :forecast_user_id, String
       property  :last_modified_by_id, String
       property  :parent_role_id, String
       property  :portal_account_id, String
       property  :portal_account_owner_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Has many relationships - May need configuration
       has n,  :users

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def last_modified_by; User.get(self.last_modified_by_id); end
    end

    class Vote
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :is_deleted, Boolean
       property  :system_modstamp, DateTime
       property  :type, String

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :parent_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :parent, :class_name => 'Name', :child_key => [:parent_id] #Reference : Name

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def parent; User.get(self.parent_id) || Lead.get(self.parent_id) || Account.get(self.parent_id) || Contact.get(self.parent_id) || Opportunity.get(self.parent_id); end
    end

    class WebLink
      include DataMapper::Resource

       def self.default_repository_name
         :salesforce
       end

       def self.salesforce_id_properties
         :id
       end

       property  :id, String, :serial => true
       property  :created_date, DateTime
       property  :description, String
       property  :display_type, String
       property  :encoding_key, String
       property  :has_menubar, Boolean
       property  :has_scrollbars, Boolean
       property  :has_toolbar, Boolean
       property  :height, Integer
       property  :is_protected, Boolean
       property  :is_resizable, Boolean
       property  :last_modified_date, DateTime
       property  :link_type, String
       property  :master_label, String
       property  :name, String
       property  :namespace_prefix, String
       property  :open_type, String
       property  :page_or_sobject_type, String
       property  :position, String
       property  :require_row_selection, Boolean
       property  :shows_location, Boolean
       property  :shows_status, Boolean
       property  :system_modstamp, DateTime
       property  :url, String
       property  :width, Integer

       #Use relationship fields manually until DM 10.* (all have corresponding record field without '_id')
       property  :created_by_id, String
       property  :last_modified_by_id, String
       property  :scontrol_id, String

       #Belongs to relationships (Unable to use without timeouts until SF adaptor upgraded to DM 10.*)
       #belongs_to  :created_by, :class_name => 'User', :child_key => [:created_by_id] #Reference : User
       #belongs_to  :last_modified_by, :class_name => 'User', :child_key => [:last_modified_by_id] #Reference : User

       #Belongs to relationships manually set via object gets until DM 10.* is implemented
       def created_by; User.get(self.created_by_id); end
       def last_modified_by; User.get(self.last_modified_by_id); end
    end
  end
end
