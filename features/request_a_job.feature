Feature: Request a new job as a customer

  As a customer
  so that I can find someone else to take the job
  I want to create a new job request

  Scenario: create a new job request
    Given I am logged in
    When I go to the "new job request" page
    When  I fill in "job_request_title" with "carpenter"
    And I fill in "job_request_description" with "constructing building"
    And I fill in "job_request_hourly_rate" with "25"
    And I fill in "job_request_location" with "Binghamton"
    And I fill in "job_request_categories" with "laborer"
    And I press "create_job_request"
    Then I should see "carpenter"
    And I should see "A new job request was successfully created"

  Scenario: fail to create a new job request when the customer hasn't provided all required information
    Given I am logged in
    When I go to the "new job request" page
    And I press "create_job_request"
    Then I should see "Title can't be blank"
    Then I should see "Description can't be blank"
    Then I should see "Location can't be blank"
    Then I should see "Hourly rate can't be blank"
    Then I should see "Categories can't be blank"
  
