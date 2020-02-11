Feature: Board's list
  Manages lists of the board

  @Acceptance
  Scenario: Update the name of a list using id
    Given Sets a "POST" request to "/boards/"
      | key  | value    |
      | name | newBoard |
    And Sends request
    And Should return status code 200
    And Saves response as "BoardObject"
    When Sets a "POST" request to "/list"
      | key     | value            |
      | name    | newListName      |
      | idBoard | (BoardObject.id) |
    And Sends request
    Then Should return status code 200
    And Saves response as "ListObject"
    And Sets a "PUT" request to "/lists/ListObject.id"
      | key  | value       |
      | name | newListName |
    And Sends request
    And Should return status code 200
    And Validates response body with
      | key  | value       |
      | name | newListName |
    And Validates schema with "put_list_schema.json"
    And Sets a "GET" request to "/lists/ListObject.id"
    And Sends request
    And Should return status code 200
    And Sets a "DELETE" request to "/boards/BoardObject.id"
    And Sends request
    And Should return status code 200
