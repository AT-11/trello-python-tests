# Created by Alan Escalera at 02/08/2020
Feature: Organization
  As a regular user, It manages a Organization

  @defect
  Scenario: Change the name of the Organization
    Given Sets a "POST" request to "/organizations/"
      | key         | value            |
      | displayName | new Organization |
    And Sends request
    And Should return status code 200
    And Saves response as "organizationObject"
    When Sets a "POST" request to "/organizations/organizationObject.id"
      | key         | value                    |
      | displayName | new Name of Organization |
    And Sends request
    Then Should return status code 200
    And Saves response as "organizationNameObject"