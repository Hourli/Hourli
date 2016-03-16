Feature: Register to Hourli
 
  As a user
  so that I may use the site
  I would want to register for an account.

Scenario: Register as a customer
  Given: I exist as a "user"
  When I click the "customer_checkbox" button
    And I fill out "attributes" as a customer
    And I click the "register" button
  Then I should see the "customer_dashboard" page
  

Scenario: Register as a contractor
  Given: I exist as a "user"
  When I click the "contractor_checkbox" button
    And I fill out "attributes" as a contractor
    And I click the "register" button
  Then I should see the "contractor_dashboard" page
  
  
Scenario: Register as both customer and contractor
  Given: I exist as a "user"
  When I click both "customer_checkbox" and "contractor_checkbox" buttons
    And I fill out "attributes" as a both customer and contractor
    And I click the "register" button
  Then I should see the "customer_dashboard" page