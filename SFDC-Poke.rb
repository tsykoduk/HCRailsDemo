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
#  acc = Account.find_all_by_phone('5555551212')
  this_run = Account.where(phone: '5555551212').count
  Account.where(phone: '5555551212').find_each do |a|
    new_phone = Faker::PhoneNumber.phone_number
    if a.phone == 555551212.to_i
      a.update(phone: new_phone)
      x += 1
      puts "update account " + a.name + ", number " + x.to_s + " of " + this_run.to_s
    end
  end
end

def runner()
  length = Float::INFINITY
  while length > 1 do
    sfdcrunner()
    sleep(60)
    dbrunner()
  end
end
    
    
runner()