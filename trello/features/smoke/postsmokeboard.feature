# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  As a regular user, Manages the board, so that creates a new board.

  Scenario: Creates new board with a name
    Given Sends a POST request to "/boards/"
      | key  | value    |
      | name | newBoard |
    When Sends request
    Then Should return status code 200
    And validate response body
    And validate schema
    And Sets a Deleted request to /boards/"(idBoard)"
    And Sends request
    And Should return status code 200
