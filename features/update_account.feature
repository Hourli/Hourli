Feature: Update a user account
  As a user
  So that I can change my account info
  I want to be able to fill out a form to specify new info

  Background: The user exists in the database and we are logged in
    Given the following user exists:
      | first_name | last_name | email              | password   | role     |
      | test       | test      | testuser@email.com | oldpass123 | customer |
    And I am logged in with email "testuser@email.com" and password "oldpass123"

  Scenario: Successfully updating the account
    When I go to the "edit user" page
    Then I should see "Edit User"
    And I fill in "Password" with "newpass123"
    And I fill in "Password confirmation" with "newpass123"
    And I fill in "Current password" with "oldpass123"
    And I press "Update"
    Then I should see "Your account has been updated successfully."

  Scenario: Unsucessfully updating the account
    When I go to the "edit user" page
    And I fill in "Password" with "newpass123"
    And I fill in "Password confirmation" with "newpass123"
    And I fill in "Current password" with "wrongpass123"
    And I press "Update"
    Then I should see "invalid"
