Feature: View flash messages in the views

  Scenario: View alert flash messages throughout the site
    Given An "alert" flash message exists
    When I reload the page for "alert"
    Then I should see an "alert" message in the top right corner of my screen

  Scenario: View notice flash messages throughout the site
    Given A "notice" flash message exists
    When I reload the page for "notice"
    Then I should see a "notice" message in the top right corner of my screen
