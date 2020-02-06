# Created by Juan Martinez at 1/31/2020
Feature: Card
  As a regular user, it wants manage a card, so it manages cards on list

  Scenario: Create a new card
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardFunctionalCard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/lists/"
      | key     | value               |
      | idBoard | (BoardObject.id)    |
      | name    | boardFunctionalList |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key         | value                 |
      | name        | functionalCard        |
      | desc        | this is a description |
      | pos         | top                   |
      | dueComplete | false                 |
      | idList      | (ListObject.id)       |
      | website     | (website)             |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key                                   | value          |
      | badges.attachmentsByType.trello.board | 0              |
      | badges.attachmentsByType.trello.card  | 0              |
      | closed                                | False          |
      | name                                  | functionalCard |
    And Validates schema with "card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
