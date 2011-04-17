Feature: Basic terminal functions

  @javascript
  Scenario: Echo
    When I go to the terminal
    And I enter the command "echo asdf"
    Then I should see a result with "asdf"
