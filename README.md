# Hourli [![Code Climate](https://codeclimate.com/github/Hourli/Hourli/badges/gpa.svg)](https://codeclimate.com/github/Hourli/Hourli)

Dev: [![Build Status](https://travis-ci.org/Hourli/Hourli.svg?branch=dev)](https://travis-ci.org/Hourli/Hourli)

Prod: [![Build Status](https://travis-ci.org/Hourli/Hourli.svg?branch=master)](https://travis-ci.org/Hourli/Hourli)

Check out http://www.agileventures.org/projects/hourli for more details

Both Heroku apps below are running the same code, it is recommended to use hourli.herokuapp.com
# Production URL
* https://hourli.herokuapp.com/

# Preproduction URL
* https://mighty-bayou-80358.herokuapp.com/

# Description
An app for independent contractors or anyone that charges an hourly fee for their services. Users can create jobs, create tasks for each job and record how long they worked on each task, what it involved, etc. Once the job is complete, the user will be able to create an invoice and send it to the customer. This app will make the lives easier of many, even private cleaning staff. The user will be able to set an hourly fee for the entire job, or for each task. The user will also be able to charge fees for miscellaneous services and include them in the total cost, which will then of course appear on the invoice in detail. The app could be integrated with paypal or any third-party payment platform to make it even easier to work with. (not part of MVP)

# Installing for development
1. Clone the repo
2. Run `bundle install --without production`
3. Run `bundle exec rake db:migrate`
4. Run `bundle exec rake db:test:prepare`
5. Install elasticsearch (via brew or apt-get or however you do it on windows)
6. Run `bundle exec rake environment elasticsearch:import:model CLASS='JobRequest'` to prepare elastic search
7. Run `elasticsearch`
8. Run rails console -> type `JobRequest.__elasticsearch__.create_index! force:true`
9. ctr+c every server you ran.
10. rerun `elasticsearch` then rerun `rails server`

# General development
*Note:* During development, any emails that are sent by devise are dumped to the server console. Make sure to check here for email confirmation links, etc.

 * Create an account, choose "both" just for convenience
 * Check the server log to find the email with the confirmation link
 * Login and start coding
 


# Installing on Heroku
* Getting this project to work on Heroku requires adding sendgrid and searchbox as addons
* You need to run `bundle exec rake "not-test_job_requests" elasticsearch:import:model CLASS='JobRequest'` to prepare searchbox

# Running the test suite
1. Make sure you ran `bundle exec rake db:test:prepare`
2. Install Firefox. This is mandatory in order to run the cucumber tests (this is so the javascript code can be tested)
3. Run `bundle exec rake cucumber` to run the cucumber test suite
4. Run `bundle exec rake spec` to run the rspec tests


# Contributing
* Join the project on http://www.agileventures.org/projects/hourli
* Fork the repo
* Follow the installing for development section above
* Submit a pull request with your proposed additions/changes
