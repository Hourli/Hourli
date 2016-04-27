Feature: Edit a job request as a customer

	As a customer
	so that I can change the information of my job requests  whenever I want
	I want to edit a job request

Background: job requests in database
  Given I have a confirmed "both" account
  And I am currently viewing as a "customer"
  And I login with valid credentials
  Given the following job requests exist:
  | title        | description               | location    | hourly_rate | categories    |
  | carpenter    | constructing building     | Binghamton  | 25          | laborer       |




Scenario: edit an existing job request
  Given I go to the "details for 'carpenter' " page 
  When I press "edit_job_request"
  Then I am on the "edit 'carpenter' " page 
  When  I fill in "job_request_title" with "housekeeper"
  And I fill in "job_request_description" with "constructing building"
  And I fill in "job_request_hourly_rate" with "25"
  And I fill in "job_request_location" with "Binghamton"
  And I fill in "job_request_categories" with "laborer"
  And I press "update_job_request"
  Then I should see "housekeeper"
  And I should see "The job request was successfully updated"


 Scenario: cancel to edit an existing job request
  When I go to the "edit 'carpenter' " page 
  When I press "cancel_to_edit_job_request"
  Then I should see "carpenter"