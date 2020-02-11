Feature: List
  Manages list of the board

  Scenario: Creates a list with name and position
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
    And Sets a "DELETE" request to "/board/Board_AObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Creates a list from another list
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


  Scenario: Modifies the list position to bottom
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
    When Sets a "PUT" request to "/lists/ListObject.id/pos"
      | key   | value  |
      | value | bottom |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | False          |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
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


  Scenario: Closes a List
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
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "PUT" request to "/lists/ListObject.id/closed"
      | key   | value |
      | value | true  |
    And Sends request
    Then Should return status code 200
    And Saves response as "List_Object"
    And Validates response body with
      | key    | value          |
      | name   | functionalList |
      | closed | True           |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/List_Object.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
    