# Hourli

Dev: [![Build Status](https://travis-ci.org/Hourli/Hourli.svg?branch=dev)](https://travis-ci.org/Hourli/Hourli)

Prod: [![Build Status](https://travis-ci.org/Hourli/Hourli.svg?branch=master)](https://travis-ci.org/Hourli/Hourli)

Check out http://www.agileventures.org/projects/hourli for more details

### Description
An app for independent contractors or anyone that charges an hourly fee for their services.

Users can create jobs, create tasks for each job and record how long they worked on each task, what it involved, etc.

Once the job is complete, the user will be able to create an invoice and send it to the customer.

This app will make the lives easier of many, even private cleaning staff.

The user will be able to set an hourly fee for the entire job, or for each task.

The user will also be able to charge fees for miscellaneous services and include them in the total cost, which will then of course appear on the invoice in detail.

The app could be integrated with paypal or any third-party payment platform to make it even easier to work with. (not part of MVP)

### Git instructions (for those unfamiliar with git)

##### Development flow
* For every feature you work on, create a new branch `git checkout -b branch-name`
* Implement your feature locally, making sure all cucumber and rspec tests pass
* When you have all tests passing and your feature is complete, submit a pull request via github. Make sure the pull request is to merge your branch into dev.
* Travis-ci will run the whole test suite to make sure all tests are passing, when travis ci is finished and provided it passes, merge the pull request.
* Repeat the above steps for all features/enhancements.

##### Updating local branches
* When there has been a change to the remote server (a.k.a GitHub). There are 2 ways to update your local repository.
* If you are currently on a branch other than dev and you want to merge in the latest dev to your current working branch, run `git pull origin dev`. Note that you didn't need to checkout dev, and do git pull origin dev
* The other way, is to `git checkout dev`, `git pull origin dev`, `git checkout branch-i-was-working-on`, `git merge dev`
* The above instructions go for any branch that multiple people might be working on, dev is just being used as an example.

*Warning*
If you have local changes to a file that were also changed on the server (GitHub) updating your local branch will cause merge conflicts or you might not be able to pull the latest changes.
This can be solved by fixing the merge conflicts or stashing. Ask Harris.


### Contributing
* Join the project on http://www.agileventures.org/projects/hourli
* Fork the repo
* Submit a pull request with your proposed additions/changes
