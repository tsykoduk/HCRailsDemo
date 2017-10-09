class Account < ActiveRecord::Base
  self.table_name = "salesforce.account"
  before_validation :assign_uuid
   
   
   
   
  private
   def assign_uuid
     self.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
   end
 end
   
  
end
