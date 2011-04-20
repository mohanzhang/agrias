Feature: Appointments

  Background:
    Given I am signed in
    And a buffer item exists with phrase: "Walk the dog", user: user "current user"
    And a buffer item exists with phrase: "Buy a dog first", user: user "current user"
    When I go to the terminal

  @javascript
  Scenario: Create an appointment from a buffer item
    When I enter the command "mk appt 2 5 days from now at 10 am"
    Then I should see a result with "Buy a dog first"

  @javascript
  Scenario: List all appointments
    Given an appointment exists with description: "Say hello", user: user "current user"
    When I enter the command "appts"
    Then I should see a result with "Say hello"
