# Create by Limbert Vargas at 1/28/2020
Feature: Manage board
  As a regular user, It wants manage board, so that it manage board.

  Scenario: # Delete a board by Id
    When Sets a DELETE request to /boards/:id endpoint
      | key     | value            |
      | idBoard | (boardObject.id) |

    And Sends request
    Then Returns 200 status code
    And should return a body
    """
    {
    "_value": null
    }
    """