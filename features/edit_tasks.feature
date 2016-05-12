Feature: Edit a task
  As a contractor
  So that I keep my tasks up to date
  I want to be able to update a task

  Background: Valid account and jobs exist in the database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    And the following job exists:
      | name                   | description                      | location                         | start_date | end_date   |
      | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |

  Scenario: Navigate to the edit page for a task
    Given the following tasks exist:
      | title   | description   | completed | duration | job_id |
      | MyTitle | MyDescription | true      | 3        | 1      |

    And I go to the "edit_task '1' '1'" page
    Then I am on the "edit_task '1' '1'" page
    And I should see "Edit Task"


  Scenario: Update a task
    Given the following tasks exist:
      | title   | description   | completed | duration | job_id |
      | MyTitle | MyDescription | true      | 3        | 1      |
    And I go to the "edit_task '1' '1'" page
    And I fill in "task_title" with "MyNewTitle"
    And I press "update_task"
    Then I am on the "view job '1'" page
    And I should see "Task successfully updated"
