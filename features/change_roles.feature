Feature: Switch between customer and contractor view
  As a customer and a contractor
  so that I can see both customer and contractor views of the site
  I would like to switch between customer and contractor modes.

  Scenario: I only have a customer account
    Given I have a confirmed "customer" account
    And I login with valid credentials
    Then I should see "Viewing as: Customer"
    And I should not see "Change role to contractor"

  Scenario: I only have a contractor account
    Given I have a confirmed "contractor" account
    And I login with valid credentials
    Then I should see "Viewing as: Contractor"
    And I should not see "Change role to customer"

  @javascript
  Scenario: I have customer and contractor accounts, am currently viewing as customer and want to view as contractor
    Given I have a confirmed "both" account
    And I am currently viewing as a "customer"
    And I login with valid credentials
    Then I should see "Change role to contractor"
    And I press "Account"
    And I wait for ajax after pressing "change_role_btn"
    Then I should see "Viewing as: Contractor"

  @javascript
  Scenario: I have customer and contractor accounts, am currently viewing as contractor and want to view as customer
    Given I have a confirmed "both" account
    And I am currently viewing as a "contractor"
    And I login with valid credentials
    Then I should see "Change role to customer"
    And I press "Account"
    When I wait for ajax after pressing "change_role_btn"
    Then I should see "Viewing as: Customer"
