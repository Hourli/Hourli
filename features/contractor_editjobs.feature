Feature: Edit/Delete a job as a contractor
  As a contractor, so that I can edit a job, I want to update the job with relevant data, or delete it
  
  Background: job in database
    Given the following job exists:
     | name  | description | location    | start_date | end_date |
     | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |
  
  Scenario: Change the name of a job
    
    Given I have a confirmed "both" account
    And I login with valid credentials
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Edit Job"
    And I fill in "Name" with "Electric - Martino Way update new"
    And I fill in "Description" with "Replace ceiling fans in bedrooms"
    And I fill in "Location" with "16 Martino Way, Pomona NY, 10970"
    And I fill in "job_start_date" with "2015-05-05"
    And I fill in "job_end_date" with "2015-05-10"
    When I press "Submit Job Changes"
    Then I should see "Electric - Martino Way update new"
    Then I should see "Replace ceiling fans in bedrooms"
    Then I should see "16 Martino Way, Pomona NY, 10970"
    Then I should see "2015-05-05"
    Then I should see "2015-05-10"
    
  Scenario: delete a job
    
    Given I have a confirmed "both" account
    And I login with valid credentials
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Delete this job"
    Then I should not see "Electric - Martino Way"