Feature: Add option for user to create the missing customer/contractor account after signup
  As a user
  so that i can use the site as both a customer and contractor
  I want to be able to view the site as both a contractor and customer even though i originally only signed up as a customer/contractor

  Scenario: I only have a customer account
    Given I have a confirmed "customer" account
    And I login with valid credentials
    Given I go to the "edit user" page
    Then I should see a "Create Contractor Account" button
    And I press "create_contractor_account"
    Then I should be both a customer and a contractor

  Scenario: I only have a contractor account
    Given I have a confirmed "contractor" account
    And I login with valid credentials
    Given I go to the "edit user" page
    Then I should see a "Create Customer Account" button
    And I press "create_customer_account"
    Then I should be both a customer and a contractor