class Account < ActiveRecord::Base
  self.table_name = "salesforce.account"
  before_validation :assign_uuid
   
   
  private
   def assign_uuid
      #Check to see if a UUID exists before creating one
      if self.external_id__c.nil?
        self.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
      end
   end
  
  
end
