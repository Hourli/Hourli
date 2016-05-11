Feature: Delete an existing job request as a customer

	As a customer
	so that I can take out invalid or finished job requests whenever I want
	I want to delete a job request

Background: job requests in database
  Given I have a confirmed "both" account
  And I am currently viewing as a "customer"
  And I login with valid credentials
  Given the following job requests exist:
  | title        | description               | location    | hourly_rate | categories    |
  | carpenter    | constructing building     | Binghamton  | 25          | laborer       |




Scenario: delete an existing job request
  When I go to the "details for 'carpenter' " page 
  And I press "delete_job_request"
  Then I am on the "viewing job requests" page
  And I should see "The job request was successfully deleted."
  And I should not see "carpenter"
  