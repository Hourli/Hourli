Feature: Accept a job offer as a customer

	As a customer
	so that I can choose a contractor to work for me after viewing all job offers
	I want to accept a job offer



Background: job request in database
  Given there is another "contractor" account
  And I have a confirmed "both" account
  And I am currently viewing as a "customer"
  And I login with valid credentials
  Given the following job requests exist:
  | title        | description               | location    | hourly_rate | categories    |
  | carpenter    | constructing building     | Binghamton  | 25          | laborer       |

  Given the following job offers for job request "carpenter" exist:
  | title            | description                     | hourly_rate | 
  | I am carpenter   | I will fix your stuff good      | 22          |              


  Scenario: accept a job offer
    Given I go to the "job offer 'I am carpenter'" page
    And I press "accept_job_offer"



  

