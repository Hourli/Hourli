Feature: Create tasks for a job
  As a contractor
  So that I can keep track of the specific tasks I finished for a job
  I want to be able to create as many tasks as I want for a job to keep myself organized

  Background: Valid account and jobs exist in the database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    And the following job exists:
      | name                   | description                      | location                         | start_date | end_date   |
      | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |

  Scenario: Navigate to new task page (for a specific job)
    Given I go to the "edit job '1'" page
    When I press "new_task"
    Then I am on the "new_task '1'" page


  Scenario: Create new task
    Given I go to the "new_task '1'" page
    When I fill in "task_title" with "MyTitle"
    And I fill in "task_description" with "MyDescription"
    And I fill in "task_duration" with "2"
    And I press "Create Task"
    Then I should see "MyTitle successfully created"
    And I am on the "edit job '1'" page
