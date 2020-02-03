# Created by Oscar Lopez at 2/3/2020
Feature: Negative test of Board
  As a regular user, Manages the board, and user Gets a board.

  Scenario: Gets a board by invalid Id
    Given I create a GET request to /boards/idBoardNotValid
    When I send the request
    Then I get a 404 status code as response
