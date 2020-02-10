# Created by Oscar Lopez at 2/10/2020
Feature: Negative test of Card
  As a regular user, It manages the card, and user Gets a Error message Error.

  Scenario: Gets a card by incorrect idCard
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/actions"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  @defect
  Scenario: Adds a wrong image sticker to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value                      |
      | name | boardFunctionalCardSticker |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/lists/"
      | key     | value                      |
      | idBoard | (BoardObject.id)           |
      | name    | boardFunctionalListSticker |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value                 |
      | name   | functionalCardSticker |
      | idList | (ListObject.id)       |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/stickers"
      | key    | value      |
      | image  | heartWrong |
      | top    | 0          |
      | left   | 47         |
      | zIndex | 1          |
    And Sends request
    Then Should return status code 401
    And Validates response message with message "invalid id"
    And Sets a "GET" request to "/cards/CardObject.id"
    Then Should return status code 401
    And Validates response message with message "invalid sticker"
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200

  Scenario: Gets the member of a card that doesn't exist
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/members"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  Scenario: Gets stickers of a card that doesn't exist
    When Sets a "GET" request to "/cards/5e3d75852b8afb5c7c60dc45invalidId/stickers"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"
