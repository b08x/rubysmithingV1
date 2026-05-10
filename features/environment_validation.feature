@environment-validation
Feature: Environment Setup Validation

  The system validates that the rubysmithing environment is properly configured
  with all required directories, environment variables, and dependencies.

  Background:
    Given I am setting up rubysmithing

  @directory-validation
  Scenario: Validate required directories exist
    When I check the environment configuration
    Then the rubysmithing config directory should exist at "~/.config/rubysmithing"
    And the gem database directory should be accessible
    And all required directories should have proper permissions

  @environment-variables
  Scenario: Validate required environment variables are set
    When I check the environment variables
    Then RUBY_GEM_DB_DIR should be defined
    And it should point to a valid directory path
    And the directory should be writable

  @database-connectivity
  Scenario: Validate database configuration and connectivity
    Given the DATABASE_URL environment variable is set
    When I test database connectivity
    Then I should be able to establish a connection
    And the database should be responsive
    And any connection errors should be clearly reported

  @missing-environment
  Scenario: Handle missing environment configuration gracefully
    Given required environment variables are not set
    When I perform environment validation
    Then I should receive clear error messages
    And each missing requirement should be listed
    And I should get guidance on how to fix the issues

  @permission-validation
  Scenario: Validate directory permissions
    Given the required directories exist
    When I check directory permissions
    Then all directories should be readable
    And writable directories should allow write access
    And any permission issues should be reported

  @dependency-check
  Scenario: Validate required dependencies are available
    When I check system dependencies
    Then all required Ruby gems should be available
    And external tools should be accessible
    And version compatibility should be verified

  @configuration-completeness
  Scenario: Validate complete environment setup
    When I perform a comprehensive environment check
    Then all environment variables should be set
    And all directories should exist with proper permissions
    And all dependencies should be available
    And the system should be ready for use

  @environment-repair
  Scenario: Provide guidance for environment setup
    Given the environment is not properly configured
    When I request environment setup guidance
    Then I should receive step-by-step environment setup instructions
    And the environment setup instructions should be specific to my platform
    And include commands to create missing environment components