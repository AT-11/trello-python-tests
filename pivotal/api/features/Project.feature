Feature: Project
  As a regular user, it wants to manage an project.

  Background:
    Given defines api as "pivotal"
    And upload credential as "admin_user"

  @Smoke
  Scenario: Adds a Project
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
