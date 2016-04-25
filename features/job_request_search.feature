Feature: Search job requests as a contractor
As a contractor,
so that I can find jobs that I'm interested in and consider taking the jobs,
I want to search for jobs requests.

Background: job requests in database

#Scenario: I search job requests by term and find them
#    Given I have a confirmed "contractor" account
#    Given Start indexing
#    And I login with valid credentials
#    And I go to the "contractor_dashboard" page
#    When I fill in "search_job_request_field" with "test"
#    When I press "search_job_requests" 
#    Then I am on the "search" page
#    Then I should see "Searching job requests for: test"
#    Then I should see "Binghamton"
#    Then I should not see "other request"

Scenario: I search job requests by term and do not find them
    Given I have a confirmed "contractor" account
    And I login with valid credentials
    And I go to the "contractor_dashboard" page
    When I fill in "search_job_request_field" with "xyz"
    When I press "search_job_requests" 
    Then I am on the "search" page
    Then I should see "Searching job requests for: xyz"
    Then I should not see "description123"
    Then I should not see "other request"

