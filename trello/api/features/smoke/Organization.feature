# Created by Juan Martinez at 1/27/2020
Feature: Organization
  As a regular user, It manages a Organization

  Scenario: Creates new Organization with a name
    When Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    Then Should return status code 200
    And Saves response as "organizationObject"
    And Validates response body with
      | key         | value            |
      | displayName | new Organization |
      | desc        |                  |
      | website     | None             |
    And Validates schema with "Create_organization.json"
    And Sets a "GET" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 200
    #Post Condition
    And Sets a "DELETE" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 200


  Scenario: Scenario: Add a member to an Organization
    Given Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    And Should return status code 200
    And Saves response as "organizationObject"
    When Sets a "PUT" request to "/organizations/organizationObject.id/members"
      | key      | value         |
      | email    | (email)       |
      | fullName | alan escalera |
    And Sends request
    And Should return status code 200
    And Saves response as "organization_membersObject"
    And Validates response body with
      | key                    | value |
      | memberships.memberType | None  |
      | members.fullName       | None  |
    And Validates schema with "put_organization_members.json"
    And Sets a "GET" request to "/organizations/organization_membersObject.id/members"
    And Sends request
    And Should return status code 200
    #Post Condition
    And Sets a "DELETE" request to "/organizations/organizationObject.id"
    And Sends request
    And Should return status code 200
