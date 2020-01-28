# Created by Alan Escalera at 1/27/2020
Feature: Acceptance of Board


  Scenario: Changes the name of the board
    Given Sets a POST request to "https://api.trello.com/1/boards/"
    And sets the following Path Params:
      | key  | value        |
      | name | GherkinBoard |
    And Sends the Post request
    And should return a "200" status code as response
    And Saves response as "BoardObject"
    And Sets a PUT request to /boards/"(BoardObject.id)"
    And sets the following Path Params
      | key     | value            |
      | name    | UpdateBoardName  |
      | idBoard | (BoardObject.id) |
    When Sends the request
    Then should return a "200" status code as response
    And validate response body
    And validate schema
    And sets a DELETE request to /boards/"(BoardObject.id)"
    And sends the Delete request
