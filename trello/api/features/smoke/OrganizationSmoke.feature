Feature: Organization
  As a regular user, It manages a Organization

  @Smoke
  Scenario: Creates new Organization
    When Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    Then Should return status code 200
    And Saves response as "organizationObject"
    And Saves endpoint to delete
    And Validates response body with
      | key         | value            |
      | displayName | new Organization |
      | desc        |                  |
      | website     | None             |
    And Validates schema with "organization_schema.json"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 200

  @Smoke
  Scenario: Delete a Organization by id
    Given Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    And Should return status code 200
    And Saves response as "organizationObject"
    When Sets a "DELETE" request to "/organizations/organizationObject.id"
    And Sends request
    Then Should return status code 200
    And Validates schema with "delete_organization_schema.json"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 404