Feature: Basic terminal functions
  Background:
    When I go to the terminal

  @javascript
  Scenario: Echo
    When I enter the command "echo asdf"
    Then I should see a result with "asdf"

  @javascript
  Scenario: Unrecognized command
    When I enter the command "wqerewqsad"
    Then I should see an error with "was not recognized"
