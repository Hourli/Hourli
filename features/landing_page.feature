Feature: Landing page

  As an anonymous user
  So that I can access the site
  I want to be able to login to my existing account.
  I want to be able to click a button to bring me to registering for a new account.
  I want to be able to view the features/selling points of the site


  Scenario: Access the site successfully as an anonymous user
    When I go to the "home" page
    Then I should see "Welcome to Hourli"
    And I should see "Signup"
    And I should see "Feature 1"
    And I should see "Feature 2"
    And I should see "Feature 3"
    And I should see "Feature 4"
    When I press "Signup"
    Then I am on the "sign up" page



