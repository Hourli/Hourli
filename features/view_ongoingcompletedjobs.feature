Feature: As a contractor
So that I can keep tabs on the jobs I have finished as well as the jobs that are currently ongoing
I want to be able to view my complete and ongoing jobs as well as edit them.

Background: job in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    Given the following job exists:
     | name  | description | location    | start_date | end_date |
     | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |
      
Scenario: An ongoing job should be seen on the ongoing tab
    
    When I go to the "Jobs" page
    Then the job named "Electric - Martino Way" should be under "Ongoing_Jobs"
    
Scenario: Change the job to completed, and it should be on the completed tab
    
    Given I go to the "Jobs" page
    Then I press "Electric - Martino Way"
    Then I press "Edit job"
    And I check "job_completed"
    When I press "Submit Job Changes"
    Then the job should be completed
    When I go to the "Jobs" page
    Then the job named "Electric - Martino Way" should be under "Completed_Jobs"
    
          
     
     