Feature: Project
  As a regular user, it wants to manage an project.

  @Smoke
  Scenario: Adds a Project
    Given upload credential as "pivotal"
    When Sets a "POST" request to "/projects/"
      | key  | value      |
      | name | newProject |
    And Sends request
    Then Should return status code 200
    And Saves response as "ProjectObject"
    And Saves endpoint to delete
    And Validates response body with
      | key                             | value      |
      | kind                            | project    |
      | name                            | newProject |
      | version                         | 1          |
      | week_start_day                  | Monday     |
      | point_scale                     | 0,1,2,3    |
      | point_scale_is_custom           | False      |
      | bugs_and_chores_are_estimatable | False      |
      | automatic_planning              | True       |
      | enable_tasks                    | True       |
      | enable_incoming_emails          | True       |
      | public                          | False      |
      | atom_enabled                    | False      |
      | project_type                    | private    |
      | enable_following                | True       |
    And Validates schema with "post_project_schema.json"
    And Sets a "GET" request to "/projects/ProjectObject.id"
    And Sends request
    And Should return status code 200


  @smoke
  Scenario: Membership operations.
    Given upload credential as "pivotal"
    And Sets a "POST" request to "/projects/"
      | key  | value         |
      | name | TestProject11 |
    And Sends request
    And Should return status code 200
    And Saves response as "ProjectObject"
    And Saves endpoint to delete
    When Sets a "POST" request to "/projects/ProjectObject.id/memberships"
      | key      | value          |
      | role     | member         |
      | email    | (email)        |
      | name     | testing_member |
      | initials | te             |
    And Sends request
    Then Should return status code 200
    And Saves response as "MemberObject"
    And Validates response body with
      | key             | value              |
      | kind            | project_membership |
      | person.kind     | person             |
      | person.name     | testing_member     |
      | person.initials | te                 |
    And Validates schema with "post_project_member_schema.json"
    And Sets a "GET" request to "/projects/ProjectObject.id/memberships/MemberObject.id"
    And Sends request
    And Should return status code 200
