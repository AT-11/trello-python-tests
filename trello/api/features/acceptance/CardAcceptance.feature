# Created by Juan Martinez at 2/6/2020
Feature: Card
  As a regular user, it wants to manage a card, and creates a card.

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