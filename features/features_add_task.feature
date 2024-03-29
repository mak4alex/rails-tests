Feature: Adding a task

  Background:
    Given a project

  @javascript
  Scenario: I can add and change priority of new task
    When I visit the page
    And I complete the new task form
    Then I am back on the project page
    And I see the new task is last in the list
    When I click to move the new task up
    Then I am back on the project page
    And the new task is in the middle of the list
