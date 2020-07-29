module CustomobjectHelper
  
  def gen_list()
    new_acct = CustomObject.new
    new_acct.name = Faker::Company.name
    new_acct.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
    new_acct.save!
  end
  
  
end
