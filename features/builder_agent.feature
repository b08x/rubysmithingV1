@builder-agent
Feature: Builder Agent Code Generation

  The Builder Agent generates code based on user prompts, leveraging the Blueprint
  Librarian for existing patterns and following rubysmithing conventions.

  Background:
    Given the rubysmithing environment is initialized
    And the Blueprint Librarian contains sample blueprints

  @code-generation
  Scenario: Generate database connection code using existing blueprint
    Given the Blueprint Librarian has a "Sequel Async Connection" pattern
    When I ask the Builder Agent to "write a new database class to connect to Postgres"
    And I specify to "check the librarian first for the async pattern"
    Then the Builder Agent should retrieve the blueprint from the librarian
    And the generated code should use the async connection pattern
    And the code should include Sequel and async requirements
    And the code should include pgvector extension setup

  @blueprint-integration
  Scenario: Builder retrieves and adapts existing blueprints
    Given I archive a blueprint with name "Redis Cache Pattern"
    And the blueprint has category "Caching"
    And the blueprint contains Redis connection code
    When I ask the Builder Agent to "create a caching layer for user sessions"
    Then the Builder should find the Redis Cache Pattern
    And adapt it for session management
    And include proper error handling

  @code-quality
  Scenario: Generated code follows Ruby conventions
    When I ask the Builder Agent to generate any Ruby class
    Then the generated code should have frozen string literal
    And should follow proper indentation
    And should include appropriate comments
    And should use snake_case for method names

  @error-handling
  Scenario: Builder handles missing blueprints gracefully
    Given no relevant blueprints exist in the librarian
    When I ask the Builder Agent to "create a custom authentication system"
    Then the Builder should generate code from scratch
    And include a note about no existing patterns found
    And follow security best practices