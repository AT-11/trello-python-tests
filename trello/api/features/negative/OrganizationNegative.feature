# Created by Enrique Carrizales at 2/10/2020
Feature: Organization
  As a regular user, It manages a Organization.

  @defect
  Scenario: Organization could not be created without name
    When Sets a "POST" request to "/organizations/"
      | key  | value        |
      | desc | without Name |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "Display Name must be at least 1 character"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 404


  @defect
  Scenario: Organization could not be created with a wrong website
    When Sets a "POST" request to "/organizations/"
      | key         | value          |
      | displayName | LIVE           |
      | website     | i am a website |
    And Sends request
    Then Should return status code 400
    And Validates response message with message "website must starting with http:// or https://"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 404
