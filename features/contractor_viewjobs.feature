Feature: View jobs list as contractor
  As a contractor
  so that I can see all my current jobs
  I should be able to go to a page that lists all jobs

  Background: job in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    Given the following job exists:
      | name                   | description                      | location                         | start_date | end_date   |
      | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |

  Scenario: the job appears on the list

    Given I go to the "Jobs" page
    Then I should see "Electric - Martino Way"
    Then I should see "Replace ceiling fans in bedrooms"
    Then I should see "16 Martino Way, Pomona NY, 10970"
