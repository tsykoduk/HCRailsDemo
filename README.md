HCRailsDemo
===========

Just a rails CRUD app to demo Heroku connect.


Setup
=====


Get a SE Demo Force app.

Click on this button:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Or, deploy the app by hand:

```
git clone https://github.com/tsykoduk/HCRailsDemo
cd HCRailsDemo
heroku create 
heroku addons:create herokuconnect:demo
heroku addons:add papertrail
heroku addons:add newrelic:stark
git push heroku master
```

Now Launch https://dashboard.heroku.com/ and locate your newly created app.
 
Click on Heroku Connect under Add-Ons

Once you launch Heroku connect, you will be asked to create a new schema and connection to your salesforce org.

Map the following fields over in Heroku Connect, or just import the ```ggn-hcdemo_connect_config.json``` file to load the configuration:

 * billingstate 
 * billingpostalcode
 * billingcountry
 * billinglatitude
 * billingcity       
 * billingstreet    
 * accountsource
 * accountnumber  
 * fax          
 * name              
 * description      
 * phone  
 * website
 * tickersymbol
 * recordtypeid 

After your first sync, your Postgres table should look like this (use `\d salesforce.account` in `heroku pg:psql` to view it)

                                                Table "salesforce.account"
          Column       |            Type             |                            Modifiers                            
    -------------------+-----------------------------+-----------------------------------------------------------------
     billingstate      | character varying(80)       | 
     fax               | character varying(40)       | 
     billinglatitude   | double precision            | 
     accountsource     | character varying(40)       | 
     billingcity       | character varying(40)       | 
     id                | integer                     | not null default nextval('salesforce.account_id_seq'::regclass)
     billingcountry    | character varying(80)       | 
     _c5_source        | character varying(18)       | 
     name              | character varying(255)      | 
     accountnumber     | character varying(40)       | 
     billingpostalcode | character varying(20)       | 
     description       | text                        | 
     sfid              | character varying(18)       | 
     billingstreet     | character varying(255)      | 
     isdeleted         | boolean                     | 
     billinglongitude  | double precision            | 
     lastmodifieddate  | timestamp without time zone | 
     phone             | character varying(40)       | 
     website           | character varying(255)      | 
     tickersymbol      | character varying(20)       | 
     recordtypeid      | character varying(18)       | 

Launch the app
```
heroku open
```
Profit

