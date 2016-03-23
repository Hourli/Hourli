Feature: Request a new job as a customer
  
  As a customer 
  so that I can find someone else to take the job
  I want to create a new job request
  
Scenario: create a new job request
  When I go to the "job request" page 
  When  I fill in "job_requests_title" with "carpenter"
  And I fill in "job_requests_description" with "constructing building"
  And I fill in "job_requests_hourly_rate" with "25"
  And I fill in "job_requests_location" with "Binghamton"
  And I fill in "job_requests_categories" with "laborer"
  And I press "create_job_request"
  Then I am on the "requested jobs" page
  And I should see "A new job request was successfully created"

Scenario: fail to create a new job request when the customer hasn't provided all required information
  When I go to the "job request" page
  And I press "create_job_request"
  Then I am on the "job request" page
  And I should see "Fail to create a job request: missing fields"
