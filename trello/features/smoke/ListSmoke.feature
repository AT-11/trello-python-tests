# Created by Juan Martinez at 1/27/2020
Feature: Manages board's list
  As a regular user, wants manage lists, so that manages lists on board

  Scenario: # Create a new list on a board
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "boardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (boardObject.id) |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    And Sets a DELETE request to "/board/(boardObject.id)"
    And Sends request
    And Should return status code 200
