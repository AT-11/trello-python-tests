# Created by Juan Martinez at 1/27/2020
Feature: # Board's list
  # Manages lists of the board
  Background:
    Given Sets board URL "https://api.trello.com/1/boards/"
    And Sets board KEY "keyValue"
    And Sets board TOKEN "tokenValue"

  Scenario: # Updates the properties of a list by id
    Given Sets POST request
      | name        |
      | boardToTest |
    When Sends POST request
    Then Should return list status code "200" OK
    And Saves board response as 'boardObject'
    And Sets POST request
      | name            |
      | newListNameTest |
    And Sends POST request
    And Should return list status code "200" OK
    And Saves list response as 'listObject'
    And Sets PUT request
      | name               |
      | newListTestUpdated |
    And Sends PUT request
    And Should return list status code "200" OK
    And Sends board DELETE request
    And Should return list status code "200" OK
    And Sends board GET request
    And Should return board "The requested resource was not found."
