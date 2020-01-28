# Created by Juan Martinez at 1/27/2020
Feature: #Manages board's list
  # As a [regular user], It wants [manage lists], so that It [manage lists on board]
  Background:
    Given Sets base URI "https://api.trello.com/1"
    And Sets KEY "keyValue"
    And Sets TOKEN "tokenValue"

  Scenario: # Create a new list on a board
    Given Sets a POST request to "/boards/"
#      | name               |
#      | newBoardPOSTToList |
      | key  | value              |
      | name | newBoardPOSTToList |
    And Sends request
    And Should return status code "200"
    And Saves response as "boardObject"
    When Sets a POST request to "/list"
#      | name         | idBoard          |
#      | newListName  | (boardObject.id) |
      | key          | value            |
      | name         | newListName      |
      | idBoard      | (boardObject.id) |
#      And set the query parameters
#      | name        | idBoard          |
#      | newListName | (boardObject.id) |
    And Sends request
    Then Should returns status code "200"
    And Validates response body
    And Validates schema
    # Post condition
    And Set a DELETE request to "/board/(boardObject.id)"
    And Sends request
    And Should return status code "200"
