# Created by Alan Escalera at 1/27/2020
Feature: # Board
    # As a current user, it wants manages a Board.

  Scenario: # Update members in a Board
    Given Sets a POST request to "/boards"
      | key  | value     |
      | name | boardTest |
    And Sends request
    And Should return status code 200
    And Save response as "board_test"
    When Sets a PUT request to "/boards/id/members"
      | key     | value           |
      | idBoard | (board_test.id) |
      | email   | (email)         |
    And sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    # Post condition
    And Set a DELETE request to "/board/(board_test.id)"
    And Sends request
    And Should return status code 200
