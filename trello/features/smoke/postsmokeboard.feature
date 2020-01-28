# Created by Oscar at 27/01/2020
Feature: Tests of Board

  Scenario: Creates new board with a name
    Given Sends a POST request to https://api.trello.com/1/boards/
        """
          {
           "name":"[newboard]"
          }
        """
    When Sends the request
    Then Gets 200 status code as response
    And  Should return body response
        """
            {
              "id": "5e292253023dc979cb1130f8",
              "name": "newboard",
              "desc": "",
              "descData": null,
              "closed": false,
              "idOrganization": null,
              "idEnterprise": null,
              "pinned": false,
              "url": "https://trello.com/b/mihCXj3X/oscarnew",
              "shortUrl": "https://trello.com/b/mihCXj3X",
        """
    And Deleted a board by Id
    When Sends a GET request to https://api.trello.com/1/boards/{idBoard}
    Then Should return status 200
    And Should return a body response
      """
          {
            "_value": null
          }
      """