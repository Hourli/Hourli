Feature: Notification System
  As a user of the site
  So that I can be informed of any actions related to my account
  I want to be able to receive and view persistent notifications related to my account

#  @javascript
#  Scenario: View number of unread notifications in the nav bar
#    Given I have a confirmed "both" account
#    And I login with valid credentials
#    And I have "3" "unread" notifications
#    When I go to the "home" page
#    Then The notification bell should display "3"
#
#  @javascript
#  Scenario: Poll for new messages
#    Given I have a confirmed "both" account
#    And I login with valid credentials
#    And I have "2" "unread" notifications
#    And I go to the "home" page
#    When I create "1" notification
#    And The browser polls for new notifications
#    Then The notification bell should display "3"
#
#  Scenario: View notification messages in a nav bar dropdown
#    Given I have a confirmed "both" account
#    And I login with valid credentials
#    And I have "2" "unread" notifications
#    Then I should see "my first notification"
#    And I should see "my second notification"
#
#  Scenario: Marking unread message as read in nav bar dropdown
#    Given I have a confirmed "both" account
#    And I login with valid credentials
#    And I have "2" "unread" notifications
#    When I press "notification_dropdown"
#    And I press "mark_read_1"
#    Then I should not see "my first notification"
#    And The notification bell should display "1"
#
  Scenario: Viewing all read and unread messages
    Given I have a confirmed "both" account
    And I login with valid credentials
    And I have "1" "unread" notifications
    And I have "2" "read" notifications
    When I press "all_messages_link"
    Then I am on the "notifications_index" page
    And I should see "notification_1"
    And I should see "notification_2"
    And I should see "notification_3"
