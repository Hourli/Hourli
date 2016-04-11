
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
    Then I should see "Electric - Martino Way"
    