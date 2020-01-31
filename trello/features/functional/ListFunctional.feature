# Created by Juan Martinez at 1/30/2020
Feature: List
  Manages list of the board

  Scenario: Create a list with all its specifications
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "boardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (boardObject.id) |
      | pos     | top              |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "list_schema.json"
    And Sets a "DELETE" request to "/board/(boardObject.id)"
    And Sends request
    And Should return status code 200
