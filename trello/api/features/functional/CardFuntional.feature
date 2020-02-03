# Created by Juan Martinez at 1/31/2020
Feature: Card
  As a regular user, it wants manage a card, so it manages cards
  on list

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
      | key         | value                     |
      | name        | functionalCard            |
      | desc        | this is a description     |
      | pos         | top                       |
      | due         | 01/31/2020                |
      | dueComplete | false                     |
      | idList      | (ListObject.id)           |
      | urlSource   | http://fundacion-jala_org |
    And Sends request
    Then Should return status code 200
    And Saves response as "CardObject"
    And Validates response body
    And Validates schema with "card_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/(BoardObject.id)"
    And Sends request
    And Should return status code 200
