Feature: Aspects

  Background:
    Given I am signed in
    And a aspect exists with name: "Social", user: user "current user"
    And a aspect exists with name: "Work", user: user "current user"
    When I go to the terminal

  @javascript
  Scenario: List aspects
    When I enter the command "aspects"
    Then I should see a result with "Social"
    And I should see a result with "Work"

  @javascript
  Scenario: Make a new root aspect
    When I enter the command "mk aspect Hello 3"
    Then I should see a result with "Hello"
    And I should see a result with "Root"

  @javascript
  Scenario: Make a new child aspect
    When I enter the command "mk aspect Hello under Social 3"
    Then I should see a result with "Hello"
    And I should see a result with "Parent: Social"
