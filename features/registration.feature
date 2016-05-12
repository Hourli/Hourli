Feature: Register to Hourli

  As a user
  so that I may use the site
  I would want to register for an account.

  Scenario: Register as a customer
    Given I go to the "sign up" page
    When I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Doe"
    And I fill in "user_email" with "testing@hourli.com"
    And I fill in "user_password" with "weakpassword"
    And I fill in "user_password_confirmation" with "weakpassword"
    When I select "Customer" from "user_role"
    And I press "user_sign_up_btn"
    Then I am on the "home" page

  Scenario: Register as a contractor
    Given I go to the "sign up" page
    When I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Doe"
    And I fill in "user_email" with "testing@hourli.com"
    And I fill in "user_password" with "weakpassword"
    And I fill in "user_password_confirmation" with "weakpassword"
    When I select "Contractor" from "user_role"
    And I press "user_sign_up_btn"
    Then I am on the "home" page

  Scenario: Register as both customer and contractor
    Given I go to the "sign up" page
    When I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Doe"
    And I fill in "user_email" with "testing@hourli.com"
    And I fill in "user_password" with "weakpassword"
    And I fill in "user_password_confirmation" with "weakpassword"
    When I select "Both" from "user_role"
    And I press "user_sign_up_btn"
    Then I am on the "home" page

  Scenario: Attempt to submit empty registration form
    Given I go to the "sign up" page
    When I press "user_sign_up_btn"
    And I should see "First name can't be blank"
    And I should see "Last name can't be blank"
    And I should see "Role can't be blank"
    And I should see "Email can't be blank"
    And I should see "Password can't be blank"
