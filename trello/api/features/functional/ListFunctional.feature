# Created by Juan Martinez at 1/30/2020
Feature: List
  Manages list of the board

  Scenario: Create a list with name and position
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
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
      | limits | {}             |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Create a list from another list
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
      | pos     | top              |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/lists/"
      | key          | value            |
      | name         | functionalList01 |
      | idListSource | (ListObject.id)  |
      | idBoard      | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "SecondObjectList"
    And Validates response body with
      | key    | value            |
      | name   | functionalList01 |
      | closed | False            |
      | limits | {}               |
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/SecondObjectList.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
