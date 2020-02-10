# Created by Juan Martinez at 09/02/2020
Feature: Organization
  As a regular user, it wants to manage a organization, and creates a organization.

  Scenario: Gets organization
    Given Sets a "POST" request to "/organizations"
      | key         | value                |
      | displayName | TeamToOrganization   |
      | desc        | This is my team AT11 |
      | name        | 123                  |
      | website     | (website)            |
    And Sends request
    And Should return status code 200
    And Saves response as "OrganizationObject"
    When Sets a "GET" request to "/organizations/OrganizationObject.id"
    And Sends request
    Then Should return status code 200
    And Saves response as "ResponseOrganizationObject"
    And Validates response body with
      | key         | value                |
      | displayName | TeamToOrganization   |
      | desc        | This is my team AT11 |
      | teamType    | None                 |
    And Validates schema with "get_organization_schema.json"
    And Sets a "DELETE" request to "/organizations/OrganizationObject.id"
    And Sends request
    And Should return status code 200
