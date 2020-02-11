Feature: Card
  As a regular user, It manages the card, and user Gets a Error message Error.

  Scenario: A list without name should not be created
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


  Scenario: Can not get a card by incorrect idCard
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/actions"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"


  Scenario: Can not get the member of a card that doesn't exist
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/members"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"


  Scenario: Can not get stickers of a card that doesn't exist
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/stickers"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"
