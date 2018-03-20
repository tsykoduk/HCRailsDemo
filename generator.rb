require 'faker'

run_times = 6400

runtimes.times do
	acct = Account.new
	acct.name = Faker::Company.name
	acct.billingcountry = Faker::Address.country
	acct.billinglatitude = Faker::Address.latitude
  acct.description = Faker::Company.catch_phrase
	acct website = "http://example.com"
	acct.billinglongitude Faker::Address.longitude
	acct.billingstate Faker::Address.state
	acct.billingstreet = Faker::Address.street_address
	acct.tickersymbol Faker::Space.agency_abv
	acct.billingcity = Faker::Address.city
 	acct.billingpostalcode = Faker::Address.postcode
	acct.phone = Faker::PhoneNumber.phone_number
	acct.fax = Faker::PhoneNumber.phone_number
  acct.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
  acct.save!
end
