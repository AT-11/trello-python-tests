# Created by Oscar Lopez at 2/3/2020
Feature: Negative test of Board
  As a regular user, Manages the board, and user Gets a board.

  Scenario: Gets a board by invalid Id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "GET" request to "/boards/idBoardNotValid"
    Then Sends request
    And Should return status code 404
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
