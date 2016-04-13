Feature: Login to my dashboard

  As a user
  so that I can see my dashboard page as landing page
  according to user's previous role.

  Scenario: I only have a customer account
    Given I have a confirmed "customer" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Then I am on the "customer_dashboard" page
    
  Scenario: I only have a contractor account
    Given I have a confirmed "contractor" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    Then I am on the "contractor_dashboard" page
    
  Scenario: I have customer and contractor accounts
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Then I am on the "customer_dashboard" page