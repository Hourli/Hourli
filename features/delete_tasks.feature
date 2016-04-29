Feature: Delete a task
  As a contractor
  So that I can delete unwanted tasks
  I want to be able to delete a task

  Background:
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    And the following job exists:
    | name  | description | location    | start_date | end_date |
    | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |


  Scenario: Delete a task
    Given the following tasks exist:
      |title    | description        | completed  | duration  | job_id |
      | MyTitle | MyDescription      |   true     | 3         |  1     |
    And I go to the "edit_task '1' '1'" page
    When I press "delete_task"
