# Created by Enrique Carrizales at 1/29/2020
Feature: Board's Functional Test
  As a regular user, Manages the board, and user creates a new label of board.

  # Created by Oscar Lopez at 1/29/2020
  Scenario: Creates new label at board with a color
    Given Sets a POST request to '/boards/"idBoard"'
      | key  | value    |
      | color | newLabelColor |
    When Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    