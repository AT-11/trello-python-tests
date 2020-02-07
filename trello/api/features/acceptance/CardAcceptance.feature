# Created by Juan Martinez at 2/6/2020
Feature: Card
  As a regular user, it wants to manage a card, and creates a card.

  Scenario: Create a new checklist on a card
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | idBoard | (BoardObject.id) |
      | name    | GherkinList      |
    And Sends request
    And Should return status code 200
    And Saves response as "ListObject"
    And Sets a "POST" request to "/cards/"
      | key    | value           |
      | idList | (ListObject.id) |
    And Sends request
    And Should return status code 200
    And Saves response as "CardObject"
    When Sets a "POST" request to "/cards/CardObject.id/checklists"
      | key  | value       |
      | name | myChecklist |
    And Sends request
    And Saves response as "CardObjectUpdate"
    And Should return status code 200
    And Validates response body with
      | key        | value       |
      | name       | myChecklist |
      | checkItems | []          |
    And Validates schema with "checklist_schema.json"
    And Sets a "GET" request to "/cards/CardObject.id"
    And Sends request
    And Should return status code 200
