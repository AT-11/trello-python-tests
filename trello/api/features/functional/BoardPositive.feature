# Created by Oscar Lopez at 2/3/2020
Feature: Create a new Board with name and description
  As a regular user, it wants to manage a board, and creates a board with description.

  Scenario: Creates a new Board with description
    When Sets a "POST" request to "/boards/"
      | key  | value          |
      | name | newBoard       |
      | desc | newDescription |
    And Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Validates response body with
      | key  | value          |
      | name | newBoard       |
      | desc | newDescription |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
    #Post Condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
