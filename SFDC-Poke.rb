#!/usr/bin/env ruby

ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/config/environment")


def sfdcrunner()
  
  puts "starting SFDC update at " + Time.now.to_s
  system("curl -s -H 'Authorization: Bearer 00Df4000003jUAV!AQcAQMIrbDWFK5ZEAzt3h5N87AXfo8ADYlQ8Cfjt0ypY8sFUStcuQqr7OFJDABnpx3t_StuFvSB2op_5gxJvUn_wkQg7PV4n' https://rainbow.my.salesforce.com/services/apexrest/massAccountTagger > /dev/null")
  puts "Finished update at " + Time.now.to_s

end

def dbrunner()
  puts "starting database update at " + Time.now.to_s
  x = 0
  acc = Account.order(:lastmodifieddate).last.limit(1000)
  acc.each do |a|
    new_phone = Faker::PhoneNumber.phone_number
    a.update(phone: new_phone)
    x += 1
    puts "update account " + acc.name + ", number " + x.to_s + " of 500"
  end
end

def runner()
  length = Float::INFINITY
  while length > 1 do
    sfdcrunner()
    dbrunner()
    puts "Sleeping for 60 seconds...."
    sleep(60)
  end
end
    
    
runner()