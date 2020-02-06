# Created by Oscar Lopez at 2/3/2020
Feature: Negative test of Board
  As a regular user, It manages the board, and user Gets a board.

  Scenario: Gets a board by invalid Id
    When  Sets a "GET" request to "/boards/idBoardNotValid"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  Scenario: Creates a new board with a name empty
    Given Sets a "POST" request to "/boards/"
      | key  | value |
      | name |       |
    When Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for name"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 400
