Feature: Hide a notification
  As a user
  so that I can hide unwanted notifications from my account
  I want to be able to hide notifications

  Scenario: Hide notification
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    And I have "3" "unread" notifications
    And I go to the "notifications_index" page
    And I should see "notification_1"
    When I press "hide_1"
    Then I should not see "notification_1"
