Feature: Login to my existing account

  Background: Not logged in
    Given I am not logged in

  Scenario: Login successfully
    Given I have a confirmed "customer" account
    When I login with valid credentials
    Then I should be logged in

  Scenario: Login with invalid email
    Given I have a confirmed "customer" account
    When I login with an invalid "email"
    Then I should not be logged in
    And I should see "Invalid email or password."

  Scenario: Login with invalid password
    Given I have a confirmed "customer" account
    When I login with an invalid "password"
    Then I should not be logged in
    And I should see "Invalid email or password."

  Scenario: Login with unconfirmed account
    Given I have an unconfirmed account
    When I login with valid credentials
    Then I should not be logged in
    And I should see "You have to confirm your email address before continuing."
