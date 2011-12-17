# URL Shortner

Redirects user to the proper full url.

## Cedar platform

This runs on the Cedar platform:

    heroku create qa-shortner --stack cedar

Add expanded logging:

    heroku addons:upgrade logging:expanded

Scale up the processes:

    heroku scale web=1 shortner=1

You need to set the following config variables:

    REDISTOGO_URL
