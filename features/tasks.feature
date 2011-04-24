Feature: Tasks

  Background:
    Given I am signed in
    And a buffer item exists with phrase: "Walk the dog", user: user "current user"
    And a buffer item exists with phrase: "Buy a dog first", user: user "current user"
    And an aspect "aspect" exists with name: "Pets and stuff", user: user "current user"
    When I go to the terminal

  @javascript
  Scenario: Create a task from a buffer item
    When I enter the command "mk task 2 under pets due in 5 days i3"
    Then I should see a result with "Buy a dog first"
    And I should see a result with "Due in 5 days"
    And I should see a result with "Importance: 3"

  @javascript
  Scenario: Complete a task
    Given a task exists with description: "Say hello", aspect: aspect "aspect", accomplished: false
    When I enter the command "next"
    And I follow "Say hello"
    And I follow "completed"

    When I enter the command "next"
    Then I should not see a result with "Say hello"
