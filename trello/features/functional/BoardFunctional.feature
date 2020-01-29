# Created by Enrique Carrizales at 1/29/2020
Feature: Board
  As a regular user, Manages the board, and user creates a new label of board.

  Scenario: Creates new color label in board
    Given Sets a POST request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Sets a POST request to '/boards/"idBoard"/labels'
      | key  | value    |
      | color | newLabelColor |
    When Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    And Sets a DELETE request to "/boards/(idBoard)"
    And Sends request
    And Should return status code 200
