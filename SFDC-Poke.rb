#!/usr/bin/env ruby



# This will run tests with random delays between each request.
# It will also ramp up RPS during certian hours and ramp down others to simulate load peaks
# It's best to run this in continuous mode

def gorun()
  
  length = Float::INFINITY

  puts "Starting a Drip Campaign..."

  while length > 1 do
      puts "starting update at " + Time.now.to_s
      system("curl -H 'Authorization: Bearer 00Df4000003jUAV!AQcAQMIrbDWFK5ZEAzt3h5N87AXfo8ADYlQ8Cfjt0ypY8sFUStcuQqr7OFJDABnpx3t_StuFvSB2op_5gxJvUn_wkQg7PV4n' https://rainbow.my.salesforce.com/services/apexrest/massAccountTagger -o '/dev/null'")
      puts "Sleep for 60 seconds at " + Time.now.to_s
      sleep(60)
  end

  #after everything is done, just sleep the sleep of the victorious.
  #this is just to keep the process from crashing and getting restarted

end

gorun()