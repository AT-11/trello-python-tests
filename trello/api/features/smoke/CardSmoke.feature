Feature: Card
  As a regular user, it wants to manage a Card.

  @Smoke
  Scenario: Creates new card
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | GherkinList      |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    When Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key                                   | value  |
      | badges.attachmentsByType.trello.board | 0      |
      | badges.attachmentsByType.trello.card  | 0      |
      | badges.location                       | False  |
      | cover.size                            | normal |
      | cover.brightness                      | light  |
    And Validates schema with "card_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200

    
  @Smoke
  Scenario: Delete a Card
    Given Sets a "POST" request to "/boards/"
      | key  | value                |
      | name | board to delete card |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | list of card     |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "DELETE" request to "/cards/CardObject.id"
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key    | value |
      | Limits | None  |
    And Validates schema with "delete_card_label_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 404
