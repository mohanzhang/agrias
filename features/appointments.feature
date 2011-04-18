Feature: Appointments

  Background:
    Given a buffer item exists with phrase: "Walk the dog"
    And a buffer item exists with phrase: "Buy a dog first"
    When I go to the terminal

  @javascript
  Scenario: Create an appointment from a buffer item
    When I enter the command "make appt 2 5 days from now at 10 am"
    Then I should see a result with "Buy a dog first"

  @javascript
  Scenario: List all appointments
    Given an appointment exists with description: "Say hello"
    When I enter the command "appts"
    Then I should see a result with "Say hello"
