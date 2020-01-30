# Created by Alan Escalera at 1/27/2020
Feature: Board
  As a regular user, it wants to manage a Board.


  Scenario: Changes the name of the board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Validates schema with "board_schema.json"
    And Saves response as "BoardObject"
    When Sets a "PUT" request to "/boards/"
      | key     | value            |
      | name    | UpdateBoardName  |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/"
      | key | value            |
      | id  | (BoardObject.id) |
    And Sends request
    And Should return status code 200


  Scenario: Updates members in a Board
    Given Sets a "POST" request to "/boards/"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Saves response as "board_test"
    When Sets a "PUT" request to "/boards/id/members"
      | key     | value           |
      | idBoard | (board_test.id) |
      | email   | (email)         |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/"
      | key | value            |
      | id  | (BoardObject.id) |
    And Sends request
    And Should return status code 200
