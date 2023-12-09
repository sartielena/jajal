# An Appwrite template on Heroku

https://github.com/appwrite/appwrite/issues/461

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/sartielena/jajal)


# Add-ons

## Bucketeer

Heroku disk is ephemeral so we must use some external storage. The Hobbyist plan is the cheapest option at $5/mo.

## JawsDB

The free database is limited to 5MB which is not enough to do anything useful.
Consider modifying plan and upgrade to Leopard ($10/mo, 1GB storage) for real traffic.

## Mailgun

The sandbox domain is not allowed to send emails to non-authorized recipients.

- Go to Mailgun dashboard, find the `Sending` section
- Select the mailgun.org subdomain
- Enter your email address in the `Authorized Recipients` sidebar on the right
- Find the email with subject `Would you like to receive emails from Heroku Account on Mailgun?` and click `I agree`
- Now you should be able to receive emails from Appwrite
