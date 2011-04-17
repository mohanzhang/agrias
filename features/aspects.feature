Feature: Aspects

  Background:
    Given a aspect exists with name: "Social"
    And a aspect exists with name: "Work"
    When I go to the terminal

  @javascript
  Scenario: List aspects
    When I enter the command "aspects"
    Then I should see a result with "Social"
    And I should see a result with "Work"

  @javascript
  Scenario: Make a new root aspect
    When I enter the command "make aspect Hello"
    Then I should see a result with "Hello"
    And I should see a result with "Root"

  @javascript
  Scenario: Make a new child aspect
    When I enter the command "make aspect Hello under Social"
    Then I should see a result with "Hello"
    And I should see a result with "Parent: Social"
