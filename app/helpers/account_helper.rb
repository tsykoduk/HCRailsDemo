module AccountHelper
  
  def account_loader(runs)
    #To load accounts;
    # Open a rails console and run helper.account_loader(NUMBER)
    runs.times do
      new_acct = Account.new
	new_acct.name = Faker::Company.name
      	new_acct.billingcountry = Faker::Address.country
	new_acct.billinglatitude = Faker::Address.latitude
     	new_acct.description = Faker::Company.catch_phrase
	new_acct.website = "http://example.com"
	new_acct.billinglongitude = Faker::Address.longitude
	new_acct.billingstate = Faker::Address.state
	new_acct.billingstreet = Faker::Address.street_address
	#new_acct.tickersymbol Faker::Space.agency_abv
	new_acct.billingcity = Faker::Address.city
	new_acct.billingpostalcode = Faker::Address.postcode
	new_acct.phone = Faker::PhoneNumber.phone_number
	new_acct.fax = Faker::PhoneNumber.phone_number
      new_acct.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
      new_acct.save!
    end
  end
  
  def guuid_creator()
    a = Account.all
    i = 0
    a.each do |b|
  	  if b.external_id__c.nil?
  		  b.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
  		  b.save
  	  end
  	  i += 1
  	  puts i
    end
    a = []
    puts "all done!"
  end


end
