# Created by Juan Martinez at 1/31/2020
Feature: Card
  As a regular user, it wants manage a card, so it manages cards on list

  Scenario: Creates a new card with parameters
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


  Scenario: Add a new comment to a card
    Given Sets a "POST" request to "/boards/"
      | key  | value               |
      | name | boardForCardComment |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | cardList         |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Should return status code 200
    And Sets a "POST" request to "/cards/CardObject.id/actions/comments"
      | key  | value             |
      | text | This is a comment |
    And Sends request
    And Should return status code 200
    And Validates response body with
      | key       | value             |
      | data.text | This is a comment |
    And Validates schema with "card_add_comment_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
