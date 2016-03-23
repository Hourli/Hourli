
Feature: Create a job as a contractor
  As a contractor
  so that I can create a job
  I want to fill out a form with relevant data and create a job
  
  Scenario: create a job as a contractor
    
  Given I am logged in
    Given I go to the "New Job" page
    And I fill in "Name" with "Electric - Martino Way"
    And I fill in "Description" with "Replace ceiling fans in bedrooms"
    And I fill in "Location" with "16 Martino Way, Pomona NY, 10970"
    And I fill in "job_start_date" with "2015-05-05"
    And I fill in "job_end_date" with "2015-05-10"
  When I press "Create"
  Then I should see "Electric - Martino Way"
  Then I should see "Replace ceiling fans in bedrooms"
  Then I should see "16 Martino Way, Pomona NY, 10970"
  Then I should see "2015-05-05"
  Then I should see "2015-05-10"
  