# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  # As a regular user, Manages the board, so that creates a nuew board.
  Scenario: Creates new board with a name
    Given Sends a POST request to https://api.trello.com/1/boards/
      | key  | value    |
      | name | newBoard |

    And Sends request
    And Should return "200" status code as response
    Then Should return a body response "jsonfiles/response_body_board.json"
    And Sets a Deleted request to /boards/"idBoard"
    Then Should return status "200"
