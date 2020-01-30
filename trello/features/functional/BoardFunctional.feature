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
    And Saves response as "board_test"
    And Sets a "POST" request to "/list"
      | key     | value           |
      | name    | newListName     |
      | idBoard | (board_test.id) |
    And Sends request
    And Should return status code 200
    When Sets a "POST" request to "/boards/"
      | key                   | value                  |
      | name                  | testBoard              |
      | defaultLabels         | false                  |
      | defaultLists          | false                  |
      | desc                  | This is a Description  |
      | idOrganization        | (organization_test.id) |
      | idBoardSource         | (board_test.id)        |
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
    And Validates schema
     # Post condition
    And Sets a "DELETE" request to "/organizations/"
      | key | value                |
      | id  | organization_test.id |
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/board/"
      | key | value         |
      | id  | board_test.id |
    And Sends request
    And Should return status code 200


  Scenario: Creates a label in board
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "board_test"
    And Sets a "POST" request to "/boards/idBoard/labels"
      | key   | value         |
      | color | newLabelColor |
    When Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    And Sets a "DELETE" request to "/boards/"
      | key | value         |
      | id  | board_test.id |
    And Sends request
    And Should return status code 200
