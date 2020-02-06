# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  As a regular user, It manages the board, and user creates a new board.

  Scenario: Creates new board with a name
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    When Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Validates response body with
      | key                   | value    |
      | name                  | newBoard |
      | desc                  |          |
      | prefs.permissionLevel | private  |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
    #Post Condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200

#  Scenario: Deletes a board by Id
#    Given Sets a "POST" request to "/boards/"
#      | key  | value    |
#      | name | newBoard |
#    And Sends request
#    And Should return status code 200
#    And Saves response as "BoardObject"
#    When Sets a "DELETE" request to "/boards/BoardObject.id"
#    And Sends request
#    Then Should return status code 200
#    And Validates response body with
#    And Validates schema with "delete_board_schema.json"
#    And Sets a "GET" request to "/boards/BoardObject.id"
#    And Sends request
#    And Should return status code 404
