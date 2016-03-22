Feature: Register to Hourli
 
  As a user
  so that I may use the site
  I would want to register for an account.
  
Background: Creating a general user account
  Given I go to the "sign up" page
  When I fill in "first_name" with "John"
  And I fill in "last_name" with "Doe"
  And I fill in "email" with "testing@hourli.com"
  And I fill in "password" with "weakpassword"
  And I fill in "password_confirmation" with "weakpassword"

Scenario: Register as a customer
  When I select "customer" from "role"
  And I click the "register" button
  Then I am on the "customer_dashboard" page

Scenario: Register as a contractor
  When I select "contractor" from "role"
  And I click the "register" button
  Then I am on the "contractor_dashboard" page
  
Scenario: Register as both customer and contractor
  When I select "both" from "role"
  And I click the "register" button
  Then I am on the "customer_dashboard" page