Feature: Make a job offer in response to a job request as a contractor

  As a contractor
  So that I can contact customers with job requests
  I would like to be able to respond to job requests with job offers

  Background: job request in database
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Given the following job requests exist:
      | title     | description           | location   | hourly_rate | categories |
      | carpenter | constructing building | Binghamton | 25          | laborer    |


  Scenario: Making a job offer
    And I am currently viewing as a "contractor"
    Given I go to the "details for 'carpenter' " page
    When I press "make_job_offer"
    Then I am on the "new job offer" page
    And I fill in "job_offer_title" with "I am carpenter"
    And I fill in "job_offer_description" with "I will fix your stuff good"
    And I fill in "job_offer_hourly_rate" with "22"
    And I press "create_job_offer"
    Then I am on the "job offer 'I am carpenter'" page
    Then I should see "A new job offer was successfully created"
    And I should see "I am carpenter"
    And I should see "I will fix your stuff good"
    And I should see "22"


  Scenario: Editing a job offer
    And I am currently viewing as a "contractor"
    Given I go to the "details for 'carpenter' " page
    When I press "make_job_offer"
    Then I am on the "new job offer" page
    And I fill in "job_offer_title" with "I am carpenter"
    And I fill in "job_offer_description" with "I will fix your stuff good"
    And I fill in "job_offer_hourly_rate" with "22"
    And I press "create_job_offer"
    Then I am on the "job offer 'I am carpenter'" page
    And I press "edit_job_offer"
    And I fill in "job_offer_title" with "I am real good carpenter"
    And I fill in "job_offer_description" with "I will fix your stuff real good"
    And I fill in "job_offer_hourly_rate" with "23"
    And I press "update_job_offer"
    Then I am on the "job offer 'I am real good carpenter'" page
    And I should see "The job offer was successfully updated"
    And I should see "I am real good carpenter"
    And I should see "I will fix your stuff real good"
    And I should see "23"

  Scenario: Canceling editing a job offer
    And I am currently viewing as a "contractor"
    Given I go to the "details for 'carpenter' " page
    When I press "make_job_offer"
    Then I am on the "new job offer" page
    And I fill in "job_offer_title" with "I am carpenter"
    And I fill in "job_offer_description" with "I will fix your stuff good"
    And I fill in "job_offer_hourly_rate" with "22"
    And I press "create_job_offer"
    Then I am on the "job offer 'I am carpenter'" page
    And I press "edit_job_offer"
    And I press "cancel_job_offer_edit"
    Then I am on the "job offer 'I am carpenter'" page

  Scenario: Deleting a job offer
    And I am currently viewing as a "contractor"
    And I am currently viewing as a "contractor"
    Given I go to the "details for 'carpenter' " page
    When I press "make_job_offer"
    Then I am on the "new job offer" page
    And I fill in "job_offer_title" with "I am carpenter"
    And I fill in "job_offer_description" with "I will fix your stuff good"
    And I fill in "job_offer_hourly_rate" with "22"
    And I press "create_job_offer"
    Then I am on the "job offer 'I am carpenter'" page
    And I press "delete_job_offer"
    Then I am on the "contractor_dashboard" page
