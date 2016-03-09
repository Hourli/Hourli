Feature: view a list of job offers and accept or deny them

As a customer,
I want to see job offers from contractors,
and I can Accept or Deny offers.

Background: a job request has been made and several contractors have submitted offers

	Given the following request exists:
	request1

	And the following offers for that request exist:
	offer1
	offer2
	offer3

Scenario: Accepting a request
	When I click accept on offer3
	Then I should be on the job page created for request1
	And I should not have request request1 anymore

Scenario: Denying a request
	When I click deny on offer1
	Then I should not see offer1
	And I should see offer2
	And I should see offer3
	When I click deny on offer2
	Then I should not see offer1
	And I should not see offer2
	And I should see offer3
	When I click deny on offer3
	Then I should have no offers