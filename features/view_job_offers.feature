Feature: View job offers as a customer
  
  As a customer 
  So that I can see job offers of my job requests
  And I can Accpet or Deny offers


  Background: job request exists in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Given the following job requests exist:
      | title        | description               | location    | hourly_rate | categories    |
      | carpenter    | constructing building     | Binghamton  | 25          | laborer       |

  Scenario: View job offers
    When I go to the "job offsers" page