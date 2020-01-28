# Created by Alan Escalera at 1/27/2020
Feature: Acceptance of Board


  Scenario: Changes the name of the board
    Given Sets a POST request to "/boards/"
    And Sets the following Path Params:
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code "200"
    And Saves response as "BoardObject"
    And Sets a PUT request to /boards/"(BoardObject.id)"
    And Sets the following Path Params
      | key     | value            |
      | name    | UpdateBoardName  |
      | idBoard | (BoardObject.id) |
    When Sends request
    Then Should return status code "200"
    And Validates response body
    And Validates schema
    And Sets a DELETE request to /boards/"(BoardObject.id)"
    And Sends request
    And Should return status code "200"
    