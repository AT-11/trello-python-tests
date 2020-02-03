# Created by Juan Martinez at 1/27/2020
Feature: Board's list
  Manages lists of the board

  Scenario: # Updates the properties of a list by id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "boardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (boardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "listObject"
    And Sets a "PUT" request to "/list/listObject.id"
      | key  | value       |
      | name | newListName |
    And Sends request
    And Should return status code 200
    And Validates response body
    And Validates schema with "list_schema.json"
    And Sets a "DELETE" request to "/board/boardObject.id"
    And Sends request
    And Should return status code 200
