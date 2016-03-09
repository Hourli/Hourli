Feature: Request a New Job as a Customer
 
  As a customer
  So that I can find someone else to take the job
  I want to request a new job
  
Scenario: create a new job request as a customer successfully
 
    Given I am on the Request a New Job page
    And I fill in "Title" with "Carpenter"
    And I fill in "Description" with "Inspect and replace damaged fixtures"
    And I fill in "Location" with "Binghamton"
    And I fill in "Hourly Rate" with "25"
    And I fill in "Categories" with "Labor"
    When I press "Create"
    Then page should have notice message "Your request for a new job was successfully created"

Scenario: fail to create a new job request as a customer 
    Given I am on the Request a New Job page
    And "Title" is empty
    When I press "Create"
    Then page should have notice message "You should fill in all the required fields"