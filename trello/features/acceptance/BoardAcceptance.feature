# Created by Alan Escalera at 1/27/2020
Feature: Acceptance of Board
  # Narrative Description: As a regurlar user, It wants to manage , so that I [benefit]

  Scenario: Changes the name of the board
    Given Sets a POST request to "https://api.trello.com/1/boards/" and save as "url"
    And sets the following Path Params:
      | key  | value        |
      | name | GherkinBoard |
    And Sends the Post request
    And should return a "200" status code as response
    And Saves response as "Board"
    And Sets a PUT request to /boards/"(Board.id)"
    And sets the following Path Params
      | key     | value            |
      | name    | newListName      |
      | idBoard | (board.id) |
    When Sends the request
    Then should return a "200" status code as response
    And should show the next JSON:
    """
      {
      "name": "BoardUpdated"
      "desc": "",
      "descData": null,
      "closed": false,
      "idOrganization": null,
      "idEnterprise": null,
      "pinned": false
      }
    """
    And validate schema
    And validate response body
    And sets a DELETE request to /boards/"(Board.id)"
    And sends the Delete request
