# Created by Alan Escalera at 1/27/2020
Feature: Board
  As a regular user, it wants to manage a Board.


#  Scenario: Changes the name of the board
#    Given Sets a "POST" request to "/boards/"
#      | key  | value        |
#      | name | GherkinBoard |
#    And Sends request
#    And Should return status code 200
#    And Saves response as "BoardObject"
#    When Sets a "PUT" request to "/boards/BoardObject.id"
#      | key  | value            |
#      | name | UpdateBoardName  |
#    And Sends request
#    Then Should return status code 200
#    And Validates response body
#  # And Validates schema with "board_schema.json"
#    # Post condition
#    And Sets a "DELETE" request to "/boards/BoardObject.id"
#    And Sends request
#    And Should return status code 200
#
#
#  Scenario: Updates members in a Board
#    Given Sets a "POST" request to "/boards/"
#      | key  | value     |
#      | name | boardTest |
#    And Sends request
#    And Should return status code 200
#    And Saves response as "board_test"
#    When Sets a "PUT" request to "/boards/board_test.id/members"
#      | key     | value           |
#      | email   | (email)         |
#    And Sends request
#    Then Should return status code 200
#    And Validates response body
#    And Validates schema with "board_schema.json"
#    # Post condition
#    And Sets a "DELETE" request to "/boards/BoardObject.id"
#    And Sends request
#    And Should return status code 200


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
