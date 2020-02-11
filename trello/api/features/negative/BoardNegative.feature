Feature: Negative test of Board
  As a regular user, It manages the board, and user Gets a board.

  Scenario: Board can't be got by invalid Id
    When  Sets a "GET" request to "/boards/idBoardNotValid"
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"

  @defect
  Scenario Outline: Board can't be created with spaces or empty as name
    Given Sets a "POST" request to "/boards/"
      | key  | value  |
      | name | <name> |
      | desc | <desc> |
    When Sends request
    Then Should return status code <status_code>
    And Saves response as "BoardObject"
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code <status_code>
    Examples:
      | name           | desc                | status_code |
      | (empty)        | This is description | 400         |
      | (blank_spaces) | This is description | 200         |

  Scenario: Can not Update members with wrong invalid Id
    When Sets a "PUT" request to "/boards/BoardObject.id/members"
      | key   | value   |
      | email | (email) |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "invalid id"


