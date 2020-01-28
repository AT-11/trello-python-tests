# Created by Oscar Lopez at 1/27/2020
Feature: Board's Test
  # As a regular user, Manages the board, so that creates a nuew board.
  Scenario: Creates new board with a name
    Given Sends a POST request to https://api.trello.com/1/boards/
      | key  | value    |
      | name | newBoard |

    And Sends request
    And Should return 200 status code as response
    Then Should return body response
        """
            {
              "id": "5e292253023dc979cb1130f8",
              "name": "[name]",
              "desc": "",
              "descData": null,
              "closed": false,
              "idOrganization": null,
              "idEnterprise": null,
              "pinned": false,
              "url": "https://trello.com/b/mihCXj3X/newboard",
              "shortUrl": "https://trello.com/b/mihCXj3X",
            }
        """

    And Sets a Deleted request to /boards/"idBoard"
    Then Should return status 200
