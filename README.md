HCRailsDemo
===========

Just a rails CRUD app to demo Heroku connect.


Setup
=====


Get a trial force org. If you do not have an external id field called `external_id__c` you will need to create one in your org. You need to insure that it's a text field and it's set up as an external id.

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

Map the following fields over in Heroku Connect, or just import the `ggn-hcdemo_connect_config.json` file to load the configuration:

 * accountnumber
 * accountsource
 * billingcity
 * billingcountry
 * billinglatitude
 * billingpostalcode
 * billingstate
 * billingstreet
 * description
 * external_id__c
 * fax
 * name
 * phone
 * recordtypeid
 * tickersymbol
 * website

You will also need to point the External ID for upserts in Connect to `external_id__c`. 

After your first sync, your Postgres table should look like this (use `\d salesforce.account` in `heroku pg:psql` to view it)

```
hcrails-dev::DATABASE=> \d salesforce.account
                                            Table "salesforce.account"
      Column       |            Type             |                            Modifiers                            
-------------------+-----------------------------+-----------------------------------------------------------------
 lastmodifieddate  | timestamp without time zone | 
 billingstreet     | character varying(255)      | 
 website           | character varying(255)      | 
 createddate       | timestamp without time zone | 
 billingpostalcode | character varying(20)       | 
 _hc_lastop        | character varying(32)       | 
 name              | character varying(255)      | 
 billinglongitude  | double precision            | 
 billingcountry    | character varying(80)       | 
 description       | text                        | 
 external_id__c    | character varying(128)      | 
 _hc_err           | text                        | 
 accountsource     | character varying(40)       | 
 phone             | character varying(40)       | 
 billinglatitude   | double precision            | 
 isdeleted         | boolean                     | 
 billingcity       | character varying(40)       | 
 id                | integer                     | not null default nextval('salesforce.account_id_seq'::regclass)
 fax               | character varying(40)       | 
 billingstate      | character varying(80)       | 
 sfid              | character varying(18)       | 
Indexes:
    "account_pkey" PRIMARY KEY, btree (id)
    "hcu_idx_account_external_id__c" UNIQUE, btree (external_id__c)
    "hcu_idx_account_sfid" UNIQUE, btree (sfid)
    "hc_idx_account_lastmodifieddate" btree (lastmodifieddate)
Triggers:
    hc_account_logtrigger AFTER INSERT OR DELETE OR UPDATE ON salesforce.account FOR EACH ROW WHEN (get_xmlbinary()::text = 'base64'::text) EXECUTE PROCEDURE salesforce.hc_account_logger()
    hc_account_status_trigger BEFORE INSERT OR UPDATE ON salesforce.account FOR EACH ROW EXECUTE PROCEDURE salesforce.hc_account_status()
```

Launch the app
```
heroku open
```
Profit

If you want to add guuid's to extisting records, you can use the following code in a Rails Console:

```
a = Account.all
i = 0
a.each do |b|
	b.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
	b.save
	i += 1
	puts i
end
```

This will load each object, and update the external_id__c feild with a random guuid.

Enjoy!
