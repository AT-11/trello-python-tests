Feature: List
  As a regular user, It manages a List.

  Scenario: A list without name could not be created
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for name"
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200


  @defect
  Scenario: A list can't be created without a correct idBoard
    When Sets a "POST" request to "/list"
      | key     | value |
      | idBoard | None  |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for id"


  @defect
  Scenario: List does not allow to set softlimit over the limit 5000
    Given Sets a "POST" request to "/boards/"
      | key  | value              |
      | name | newBoardPOSTToList |
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
    When Sets a "PUT" request to "/lists/ListObject.id/softLimit"
      | key   | value |
      | value | 5001  |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid value for value"
    And Sets a "DELETE" request to "/board/BoardObject.id"
    And Sends request
    And Should return status code 200
