Feature: View the current status of jobs as a customer

  Scenario: View existent ongoing jobs
    Given I am on the customer home page
    And I have ongoing jobs
    When I click on the "ongoing jobs" tab
    Then I should see all of the ongoing jobs for my account
    And The jobs should be paginated

  Scenario: View existent completed jobs
    Given I am on the customer home page
    And I have completed jobs
    When I click on the "completed jobs" tab
    Then I should see all of the completed jobs for my account
    And The jobs should be paginated

  Scenario: View nonexistent ongoing jobs
     Given I am on the customer home page
     And I do not have any ongoing jobs
     When I click on the "ongoing jobs" tab
     Then I should not see any ongoing jobs

  Scenario: View nonexistent completed jobs
     Given I am on the customer home page
     And I do not have any completed jobs
     When I click on the "completed jobs" tab
     Then I should not see any completed jobs
