Feature: Display tasks for the given job
  As a contractor
  So that I can view the tasks for a job
  I want to be able to view the tasks associated with one of my jobs

  Background: Valid account and jobs exist in the database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    And the following job exists:
      | name                   | description                      | location                         | start_date | end_date   |
      | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |

  Scenario: Display a jobs' tasks
    Given the following tasks exist:
      | title    | description    | completed | duration | job_id |
      | MyTitle1 | MyDescription1 | true      | 3        | 1      |
      | MyTitle2 | MyDescription2 | false     | 4        | 1      |
    And I go to the "view job '1'" page
    And I should see "Tasks for this job:"
    And I should see "MyTitle1"
    And I should see "MyDescription1"
    And I should see "3"
    And I should see "MyTitle2"
    And I should see "MyDescription2"
    And I should see "4"

  Scenario: Navigate to a task's edit page
    Given the following tasks exist:
      | title    | description    | completed | duration | job_id |
      | MyTitle1 | MyDescription1 | true      | 3        | 1      |
    And I go to the "view job '1'" page
    When I press "edit_1"
    Then I am on the "edit_task '1' '1'" page

  Scenario: When a job has no tasks
    Given I go to the "view job '1'" page
    Then I should see "You do not have any tasks"
