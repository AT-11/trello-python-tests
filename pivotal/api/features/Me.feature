Feature: Credential

  Scenario: Get Credential
    Given upload credential like "pivotal"
    And Sets a "GET" request to "/me"
    And Sends request
    And Should return status code 200