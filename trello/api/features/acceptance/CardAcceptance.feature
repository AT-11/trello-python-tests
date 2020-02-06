# Created by Alan Escalera at 1/27/2020
Feature: Card
  As a regular user, it wants to manage a Card.

  Scenario: Creates new card
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | GherkinList      |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
      | name   | GherkinCard     |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body with
      | key                                   | value |
      | badges.attachmentsByType.trello.board | 0     |
      | badges.attachmentsByType.trello.card  | 0     |
      | badges.location                       | False |
    And Validates schema with "card_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
