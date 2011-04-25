Feature: Visualizations
  Background:
    Given I am signed in
    And an aspect "parent" exists with name: "Pets and stuff", user: user "current user"
    And a task exists with aspect: aspect "parent", description: "This is important", state: 1
    And a task exists with aspect: aspect "parent", description: "This is accomplished", state: 4
    When I go to the terminal

  @javascript
  Scenario: Can see next tasks
    When I enter the command "next"
    Then I should see a result with "This is important"
    And I should not see a result with "This is accomplished"

  @javascript
  Scenario: Shows only the buffer when buffer is full
    Given a buffer item exists with user: user "current user"
    Given a buffer item exists with user: user "current user"
    Given a buffer item exists with user: user "current user"
    Given a buffer item exists with user: user "current user"
    Given a buffer item exists with user: user "current user"
    Given a buffer item exists with user: user "current user"
    When I enter the command "next"
    Then I should not see a result with "This is important"
    And I should see a result with "Buffer has more than 5 items"

