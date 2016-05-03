Feature: View pending job requests as a customer
  
  As a customer 
  So that I can see the status of my job requests
  I want a list of my job requests to be part of the customer dashboard


  Background: job and job request exists in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Given the following job requests exist:
      | title        | description               | location    | hourly_rate | categories    |
      | carpenter    | constructing building     | Binghamton  | 25          | laborer       |
    Given the following job exists:
       | name  | description | location    | start_date | end_date |
       | Electric - Martino Way | Replace ceiling fans in bedrooms | 16 Martino Way, Pomona NY, 10970 | 2015-05-05 | 2015-05-10 |
       | Random completed job | some random stuff | 12 Address Lane | 2015-05-05 | 2015-05-10 |
    And the job named "Electric - Martino Way" belongs to the current user's customer account
    And the job named "Random completed job" belongs to the current user's customer account
    And the job named "Random completed job" is completed

  Scenario: View job requests
    When I go to the "view job requests" page 
    Then the job named "carpenter" should be under "Your Job Requests"
    And the job named "Electric - Martino Way" should be under "Ongoing Jobs"
    And the job named "Random completed job" should be under "Completed Jobs"
