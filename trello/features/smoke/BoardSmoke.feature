# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  As a regular user, Manages the board, and user creates a new board.

  Scenario: Creates new board with a name
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    When Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Validates response body
    And Validates schema with "board_schema.json"
    And Sets a "DELETE" request to "/boards/"
      | key | value                 |
      | id  | (BoardObject.idBoard) |
    And Sends request
    And Should return status code 200
    #And Validates schema with "delete_schema.json"

    # Create by Limbert Vargas at 1/28/2020
  Scenario: Deletes a board by Id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "DELETE" request to "/boards/"
      | key     | value            |
      | idBoard | (BoardObject.idBoard) |
    Then Sends request
    And Should return status code 200
