Feature: Create a job as a contractor
  As a contractor
  so that I can create a job
  I want to fill out a form with relevant data and create a job
  
  Scenario: create a job as a contractor
    
  Given I exist as a contractor user
    And I am logged in
    And I am on the "View Jobs" page
    And I fill in "Title" with "Electric - Martino Way"
    And I fill in "Description" with "Replace ceiling fans in bedrooms"
    And I fill in "Location" with "16 Martino Way, Pomona NY, 10970"
    And I fill in "Start Date" with "March 2015"
    And I fill in "End Date" with "N/A"
    And I fill in "tags" with "electric, ceiling fans"
  When I press "Submit"
  Then I should be on the "View Jobs" page
  And I should see the created job