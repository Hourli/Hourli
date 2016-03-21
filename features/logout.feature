Feature: Logout
  Scenario: Logout after logging in
    Given I am logged in
    When I logout
    Then I should not be logged in
