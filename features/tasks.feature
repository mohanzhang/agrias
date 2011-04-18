Feature: Tasks

  Background:
    Given a buffer item exists with phrase: "Walk the dog"
    And a buffer item exists with phrase: "Buy a dog first"
    And an aspect exists with name: "Pets and stuff"
    When I go to the terminal

  @javascript
  Scenario: Create a task from a buffer item
    When I enter the command "make task 2 under pets due in 5 days"
    Then I should see a result with "Buy a dog first"
    And I should see a result with "Due in 5 days"
