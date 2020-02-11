# Created by Juan Martinez at 1/27/2020
Feature: Manages board's list
  As a regular user, It manages a lists, so that manages lists on board

  @Smoke
  Scenario: Create a new list on a board
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Validates response body with
      | key    | value       |
      | name   | newListName |
      | closed | False       |
      | limits | {}          |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
