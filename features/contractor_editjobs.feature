Feature: Edit/Delete a job as a contractor
  As a contractor, so that I can edit a job, I want to update the job with relevant data, or delete it
  
  Background: job in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    Given the following job exists:
     | name  | description | location    | start_date | end_date |
     | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |
  
  Scenario: Change the name of a job
    
    
    Given I go to the "Jobs" page
    Then I press "job_1"
    Then I press "Edit job"
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
    
    Scenario: Change the job to completed
    
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Edit job"
    And I check "job_completed"
    When I press "Submit Job Changes"
    Then the job should be completed
    
    Scenario: Change the job to not completed
    
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Edit job"
    And I uncheck "job_completed"
    When I press "Submit Job Changes"
    Then the job should not be completed
    
    Scenario: delete a job
    
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Delete this job"
    Then I should not see "Electric - Martino Way"
