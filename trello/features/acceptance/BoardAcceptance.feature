# Created by Alan Escalera at 1/27/2020
Feature: Board
  As a regular user, it wants to manage a Board.


  Scenario: Changes the name of the board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "PUT" request to "/boards/BoardObject.id"
      | key  | value           |
      | name | UpdateBoardName |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Updates members in a Board
    Given Sets a "POST" request to "/boards/"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Saves response as "board_test"
    When Sets a "PUT" request to "/boards/board_test.id/members"
      | key   | value   |
      | email | (email) |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Marked as a viewer the board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/boards/BoardObject.id/markedAsViewed"
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Add label to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value      |
      | name | BoardLabel |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/boards/BoardObject.id/labels"
      | key   | value       |
      | name  | nameOfLabel |
      | color | yellow      |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Add tag to existent board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | postBoardTag |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Sets a "POST" request to "/organizations"
      | key         | value                     |
      | displayName | postOrganization          |
      | desc        | This a description        |
      | name        | thisIsName                |
      | website     | http://fundacion-jala.org |
    And Sends request
    And Should return status code 200
    And Saves response as "OrganizationObject"
    When Sets a "POST" request to "/boards/OrganizationObject.id/idTags"
      | key   | value                   |
      | id    | (BoardObject.id)        |
      | value | (OrganizationObject.id) |
    And Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/organizations/OrganizationObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Add powerUps to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value             |
      | name | postBoardPowerUps |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/boards/BoardObject.id/powerUps"
      | key   | value    |
      | value | calendar |
    And Sends request
    Then Should return status code 410
    And Validates response body
    And Validates schema with "board_schema.json"
    # Post condition
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
