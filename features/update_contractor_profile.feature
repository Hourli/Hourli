Feature: Update a contractor profile
  As a contractor
  In order to update my contractor profile
  I want to be able to fill out a form to specify new info

  Background: The user exists in the database and we are logged in
    Given the following user exists:
      | first_name | last_name | email              | password   | role     |
      | test       | test      | testuser@email.com | oldpass123 | customer |
    And I am logged in with email "testuser@email.com" and password "oldpass123"
    And the user with email "testuser@email.com" has a contractor account

  Scenario: updating the contractor profile
    When I go to the "edit contractor profile" page
    Then I should see "Edit Contractor"
    And I fill in "Occupation" with "new occupation"
    And I press "Update"
    Then I should see "Successfully updated contractor profile!"
