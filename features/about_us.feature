Feature: About Us page

As somebody interested in the project,
I want to see who created the project,
so that I may hire them.

Scenario: There is link to the about us page
	When I go to the "home" page
	And I click on about us link
	Then I am on the "about us" page

Scenario: Each creator is listed on the about us page
	When I go to the "about us" page
	Then I should see "Evan Young"
	Then I should see "Harris Pittinsky"
	Then I should see "Jonathan Ball"
	Then I should see "Jordan Cangialosi"
	Then I should see "Seong Kim"
	Then I should see "Xinyuan Wang"
