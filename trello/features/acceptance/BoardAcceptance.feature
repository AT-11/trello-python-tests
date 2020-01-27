# Created by Alan at 1/27/2020
Feature: CRUD of Board

  Scenario: Change the name of a board
    Given Sets a POST request to "https://api.trello.com/1/boards/" and save as "url"
    And sets the following Path Params
    """
      {
      "name": "GherkinBoard"
      }
    """
    And Sends the Post request
    And should return a "200" status code as response
    And should show the next JSON:
    """
      {
      "name": "GherkinBoard",
      "desc": "",
      "descData": null,
      "closed": false,
      "idOrganization": null,
      "idEnterprise": null,
      "pinned": false
      }
    """
    And Sets a PUT request to /boards/"Board.id"
    And sets the following Path Params
       """
        {
          "id": "{Board.id}"
          "name":"BoardUpdated"
        }
       """
    Then Sends the Put request
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
    And sets a DELETE request to "/boards/"Board.id"
    And sends the Delete request
