Feature: Contractor Profile
  As a customer who has created a job request,
  When I receieve a job offer from a contractor,
  I should be able to view the contractors profile,
  So that I can make a good choice whether to accept/deny the offer

  Background: Contractor has made an offer on my job

    Given that I am logged in as a Customer.
    Given that I have created a Job Request.
    Given that a Contractor has made an offer for my Job.

    And I am on the View Job Offers page

  Scenario: Contractor has no experience
    Given the Contractor has no experience
    And I click on the View Contractor Profile
    Then the page should show "Experience: None"

  Scenario: Contractor has experience
    Given the Contractor has experience "Test experience"
    And I click on the View Contractor Profile
    Then the page should show "Experience: Test experience"

  Scenario: Contractor has no description
    Given the Contractor has no description
    And I click on View Contractor Profile
    Then the page should show "Description: None."

  Scenario: Contractor has description
    Given the Contractor has description "Test description"
    And I click on View Contractor Profile
    Then the page shodul show "Description: Test description"
  


