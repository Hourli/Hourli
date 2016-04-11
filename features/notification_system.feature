Feature: Notification System
  As a user of the site
  So that I can be informed of any actions related to my account
  I want to be able to receive and view persistent notifications related to my account

  @javascript
  Scenario: View number of unread notifications in the nav bar
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "3" "unread" notifications
    When I go to the "home" page
    Then The notification bell should display "3"

  @javascript
  Scenario: Poll for new messages
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "2" "unread" notifications
    And I go to the "home" page
    When I create "1" notification
    And The browser polls for new notifications
    Then The notification bell should display "3"

  Scenario: Viewing all read and unread messages (messages exist)
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "1" "unread" notifications
    And I have "2" "read" notifications
    When I press "all_messages_link"
    Then I am on the "notifications_index" page
    And "notification_1" should be an unread message
    And "notification_2" should be a read message
    And "notification_3" should be a read message

  Scenario: Viewing all read and unread messages (messages do not exist)
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "0" "unread" notifications
    And I have "0" "read" notifications
    When I press "all_messages_link"
    Then I am on the "notifications_index" page
    And I should see "You do not have any notifications"

  @javascript
  Scenario: View notification messages via nav bar dropdown
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I am on the "home" page
    And I have "2" "unread" notifications
    And I press "notification_dropdown"
    Then I should see "notification_1" in "notification_1"
    And I should see "notification_2" in "notification_2"

  @javascript
  Scenario: Marking unread message as read via nav bar dropdown
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "2" "unread" notifications
    When I press "notification_dropdown"
    And I press "toggle_read_status_1"
    Then I should not see "notification_1"
    And The notification bell should display "1"

  @javascript
  Scenario: Mark all notifications as read via notification index page
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "3" "unread" notifications
    And I go to the "notifications_index" page
    When I press "mark_all_as_read_link"
    Then The notification bell should display ""
    And "notification_1" should be a read message
    And "notification_2" should be a read message
    And "notification_3" should be a read message
