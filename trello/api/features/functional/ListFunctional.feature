# Created by Juan Martinez at 1/30/2020
Feature: List
  Manages list of the board

  Scenario: Create a list with all its specifications
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    #And Validates response body
    #And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
