Feature: Credential
  As a regular user, it wants to manage an account.

  @Smoke
  Scenario: Gets Credential
    Given upload credential as "pivotal"
    When Sets a "GET" request to "/me"
    And Sends request
    Then Should return status code 200
    And Saves response as "MeObject"
    And Validates response body with
      | key                           | value |
      | kind                          | me    |
      | receives_in_app_notifications | True  |
    And Validates schema with "get_me_schema.json"
