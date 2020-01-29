# Created by Limbert Vargas at 1/29/2020
Feature: #Enter feature name here
  # Enter feature description here

  Scenario: Creates new 
    Given Sets a POST request to "/boards/"
      | key  | value    |
      | name | newBoard |
    When Sends request
    Then Should return status code 200
    And Validates response body
    And Validates schema
    And Sets a DELETE request to "/boards/(idBoard)"
    And Sends request
    And Should return status code 200
