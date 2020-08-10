HCRailsDemo
===========

7/29 - renamed master branch to main

Just a rails CRUD app to demo Heroku connect. It is set up to sync the Account object down. It relies on a field called external_id__c as it's external ID for upserts. The rails app will do the "right thing" and automatically generate a guid for any records created there. It's left up to the gentle reader to extend their salesforce org to "do the right thing" and generate a guid on the account object.

Setup
=====

Get a trial force org. If you do not have an external id field called `external_id__c` you will need to create one in your on the account object in Salesforce. You need to insure that it's a text field and it's set up as an external id.

Click on this button:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Or, deploy the app by hand:

```
git clone https://github.com/tsykoduk/HCRailsDemo
cd HCRailsDemo
heroku create
heroku addons:create herokuconnect
heroku addons:create papertrail
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

You will also need to point the External ID for upserts in Connect to `external_id__c`. If you have a starting SFDC demo org, you should create a the `external_id__c` custom field.

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

If you want to add guuids to existing records, you can open a console using `heroku run console` and then run `helper.guuid_creator`. This will load each record in the account object, and update the external_id__c field with a random guid if one does not already exist. This could take some time.

If you want to load more accounts, follow the steps above to deploy and set up the demo. Then simply pop open a Rails Console with `heroku run console`. Once you have a console up and running run `helper.account_loader(#)` where # is the number of records you want to create.


Enjoy!
