class Account < ActiveRecord::Base
  self.table_name = "salesforce.account"
  after_create_commit :assign_uuid
   
   def assign_uuid
     uuid = SecureRandom.uuid + Time.now().to_i.to_s
     Self.external_id__c = uuid
     Self.save
   end
   
  
end
