# Created by Juan Martinez at 1/30/2020
Feature: List
  Manages list of the board

  Scenario: Moves a list from a board to another one
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardFunctional |
    And Sends request
    And Should return status code 200
    And Saves response as "Board_AObject"
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | functionalList   |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "PUT" request to "/lists/ListObject.id/idBoard"
      | key   | value              |
      | value | (Board_AObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListMoved"
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
    And Validates schema with "put_move_list.json"
    And Sets a "GET" request to "/lists/ListMoved.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/Board_AObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Moves all cards from list to another list
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | newBoardList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newFistList      |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "FirstListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                |
      | idList | (FirstListObject.id) |
      | name   | newFirstCard         |
    And Sends request
    And Should return status code 200
    And Saves response as "FirstCardObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                |
      | idList | (FirstListObject.id) |
      | name   | newSecondCard        |
    And Sends request
    And Should return status code 200
    And Saves response as "SecondCardObject"
    And Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newSecondList    |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "SecondListObject"
    When Sets a "POST" request to "/lists/FirstListObject.id/moveAllCards"
      | key     | value                 |
      | idBoard | (BoardObject.id)      |
      | idList  | (SecondListObject.id) |
    And Sends request
    Then Should return status code 200
    And Validates schema with "list_move_cards_to_list.json"
    And Sets a "GET" request to "/lists/SecondListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
