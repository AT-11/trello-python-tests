# Created by Juan Martinez at 1/27/2020
Feature: #Board's list
  # Manages lists of the board
  Background:
    Given Sets board URL "https://api.trello.com/1/boards/"
    And Sets board KEY "keyValue"
    And Sets board TOKEN "tokenValue"

  Scenario: # Create a new list on a board
    Given Sets value to POST request
      | name               |
      | newBoardPOSTToList |
    When Sends board POST request
    Then Should return board status code "200" OK
    And Saves board object as "boardObject"
    And Sets POST request to
      | name        | idBoard          |
      | newListName | {boardObject.id} |
    And Sends POST request
    And Sends board DELETE request
    And Should return board status code "200" OK
    And Sends board GET request
    And Should return board "The requested resource was not found."
