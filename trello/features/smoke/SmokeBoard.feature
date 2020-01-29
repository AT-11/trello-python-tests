# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  As a regular user, Manages the board, and user creates a new board.

  Scenario: Creates new board with a name
    Given Sets a POST request to "/boards/"
      | key  | value    |
      | name | newBoard |
    When Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    And Sets a DELETE request to "/boards/(idBoard)"
    And Sends request
    And Should return status code 200

    # Create by Limbert Vargas at 1/28/2020
  Scenario: Deletes a board by Id
    Given Sets a POST request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200

    When Sets a DELETE request to "/boards/(id)"
      | key     | value            |
      | idBoard | (boardObject.id) |

    And Sends request
    Then Should returns status code 200
    And Validates response body
    And Validates schema
