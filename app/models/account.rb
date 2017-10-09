class Account < ActiveRecord::Base
  self.table_name = "salesforce.account"
  before_create_commit :assign_uuid
   
   def assign_uuid
     uuid = SecureRandom.uuid + Time.now().to_i.to_s
     self.external_id__c = uuid
     self.save
   end
   
  
end
