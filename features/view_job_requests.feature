Feature: View pending job requests as a customer
  
  As a customer 
  So that I can see the status of my job requests
  I want a list of my job requests to be part of the customer dashboard


  Background: job request exists in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Given the following job requests exist:
      | title        | description               | location    | hourly_rate | categories    |
      | carpenter    | constructing building     | Binghamton  | 25          | laborer       |

  
  Scenario: View job requests
    When I go to the "view job requests" page 
    Then I should see "carpenter"
    And I should see "constructing building"
    And I should see "Binghamton"
    And I should see "25"
    And I should see "laborer"
