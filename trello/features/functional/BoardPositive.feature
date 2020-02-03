# Created by Admin at 2/3/2020
Feature: Create a new Board with and without label
  As a regular user, Manages the board, and user Creates a board without label.

  Scenario : Creates a new Board with description
    Given Sets a "POST" request to "/boards/"
      | key  | value          |
      | name | newBoard       |
      | desc | newDescription |
    When Sends request
    Then Should return status code 200
    And Saves response as "BoardObject"
    And Validates response body
    And Validates schema with "board_schema.json"
    #Post Condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
