# Created by Oscar Lopez at 2/3/2020
Feature: Negative test of Board
  As a regular user, Manages the board, and user Gets a board.

  Scenario: Gets a board by invalid Id
    When  Sets a "GET" request to "/boards/idBoardNotValid"
    And Sends request
    Then Should return status code 404
