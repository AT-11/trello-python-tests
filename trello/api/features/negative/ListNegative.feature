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
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 400
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
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 400

  Scenario: Card with an incorrect id can not be found
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/actions"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  Scenario: It does not allow to find an non-existent member in card
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/members"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  Scenario: A card that doesn't exist don't gets a stickers
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/stickers"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"