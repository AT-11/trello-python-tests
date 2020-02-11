Feature: Board
  As a regular user, it wants to manage a Board.

  @Acceptance
  Scenario: Changes the name of the board
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/boards/BoardObject.id"
      | key  | value           |
      | name | UpdateBoardName |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key  | value           |
      | name | UpdateBoardName |
    And Validates schema with "board_schema.json"
    And Sets a "GET" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Updates members in a Board
    Given Sets a "POST" request to "/boards/"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "PUT" request to "/boards/BoardObject.id/members"
      | key   | value   |
      | email | (email) |
    And Sends request
    Then Should return status code 200
    And Validates response body with
      | key                     | value |
      | members.activityBlocked | None  |
      | memberships.memberType  | None  |
      | memberships.nonPublic   | None  |
    And Validates schema with "put_boards_members.json"
    And Sets a "GET" request to "/boards/BoardObject.id/members"
    And Sends request
    And Should return status code 200


  @defect
  Scenario: Board marked as a viewed
    Given Sets a "POST" request to "/boards/"
      | key  | value        |
      | name | GherkinBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/markedAsViewed"
    And Sends request
    Then Should return status code 200
    And Validates schema with "board_schema.json"


  @Acceptance
  Scenario: Add label to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value      |
      | name | BoardLabel |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/labels"
      | key   | value       |
      | name  | nameOfLabel |
      | color | yellow      |
    And Sends request
    Then Should return status code 200
    And Saves response as "LabelObject"
    And Validates response body with
      | key   | value       |
      | name  | nameOfLabel |
      | color | yellow      |
    And Validates schema with "label_schema.json"
    And Sets a "GET" request to "/labels/LabelObject.id"
    And Sends request
    And Should return status code 200


  @Acceptance
  Scenario: Add powerUps to existent Board
    Given Sets a "POST" request to "/boards/"
      | key  | value             |
      | name | postBoardPowerUps |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/boards/BoardObject.id/powerUps"
      | key   | value    |
      | value | calendar |
    And Sends request
    Then Should return status code 410
    And Validates response body with
      | key     | value |
      | message | Gone  |
    And Validates schema with "powerups_schema.json"
