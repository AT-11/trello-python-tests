# Created by Enrique Carrizales at 1/29/2020
Feature: Board

  As a regular user, it wants to manage a board.

  Scenario: Create a board with all parameters
    Given Sets a "POST" request to "/organizations"
      | key         | value             |
      | displayName | organization_test |
    And Sends request
    And Should return status code 200
    And Saves response as "organization_test"
    And Sets a "POST" request to "/boards/"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/lists/"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (BoardObject.id) |
    And Sends request
    And Should return status code 200
    When Sets a "POST" request to "/boards/"
      | key                   | value                  |
      | name                  | testBoard              |
      | defaultLabels         | false                  |
      | defaultLists          | false                  |
      | desc                  | This is a Description  |
      | idOrganization        | (organization_test.id) |
      | idBoard               | (BoardObject.id)       |
      | keepFromSource        | (cards)                |
      | powerUps              | all                    |
      | prefs_permissionLevel | public                 |
      | prefs_voting          | members                |
      | prefs_comments        | members                |
      | prefs_invitations     | admins                 |
      | prefs_selfJoin        | false                  |
      | prefs_cardCovers      | false                  |
      | prefs_background      | pink                   |
      | prefs_cardAging       | pirate                 |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
     # Post condition
    And Sets a "DELETE" request to "/organizations/organization_test.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Creates a label in board
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/labels"
      | key     | value            |
      | name    | newLabel         |
      | color   | green            |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "LabelObject"
    And Validates response body
    And Validates schema with "label_schema.json"
    And Sets a "GET" request to "/labels/LabelObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Creates a list in board
  This scenario allows to create a list on an existing board

    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/lists"
      | key     | value            |
      | name    | newList          |
      | idBoard | (BoardObject.id) |
    When Sends request
    Then Should return status code 200
     And Saves response as "ListObject"
    And Validates schema with "list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Validates response body
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
