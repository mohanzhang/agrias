Feature: Buffer items

  Background:
    Given a buffer item exists with phrase: "Walk the dog"
    And a buffer item exists with phrase: "Buy a dog first"
    When I go to the terminal

  @javascript
  Scenario: List buffer items
    When I enter the command "buffer"
    Then I should see a result with "Walk the dog"
    And I should see a result with "Buy a dog first"

  @javascript
  Scenario: Buffer a new item
    When I enter the command "buf wash the car"
    Then I should see a result with "wash the car"
