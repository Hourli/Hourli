Feature: Contact Us page

  As a potential contributor,
  I want to see a contact us page,
  so that I may contact the creators of Hourli.

  Scenario: There is link to the contact us page
    When I go to the "home" page
    And I click on contact us link
    Then I am on the "contact us" page

  Scenario: There is a link to the github and agile ventures pages on the contact us page
    When I go to the "contact us" page
    Then I should see "Github"
    Then I should see "Agile Ventures"
