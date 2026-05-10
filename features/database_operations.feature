@database-operations
Feature: Database Migration and Management

  The system manages database schema migrations and ensures proper database
  setup for rubysmithing operations including blueprint storage and gem metadata.

  Background:
    Given the rubysmithing environment is initialized
    And database configuration is available

  @database-migration
  Scenario: Successfully migrate database schema
    Given the DATABASE_URL is properly configured
    And a database connection can be established
    When I run the database migration
    Then the migration should complete successfully
    And all required tables should be created
    And the schema version should be updated

  @migration-failure-handling
  Scenario: Handle migration failures gracefully
    Given the database is unavailable or misconfigured
    When I attempt to run the database migration
    Then the migration should fail with a clear error message
    And the error should include diagnostic information
    And the system should remain in a stable state

  @connection-validation
  Scenario: Validate database connection before migration
    When I check the database connection
    Then I should verify the DATABASE_URL is set
    And the database should be reachable
    And authentication should be successful
    And the connection should be properly established

  @schema-verification
  Scenario: Verify database schema after migration
    Given the database migration has been completed
    When I inspect the database schema
    Then all required tables should exist
    And each table should have the correct columns
    And indexes should be properly created
    And constraints should be in place

  @migration-rollback
  Scenario: Rollback failed or incorrect migrations
    Given a migration has introduced issues
    When I perform a migration rollback
    Then the database should be restored to the previous state
    And all data integrity should be maintained
    And the rollback should be logged appropriately

  @concurrent-migration-safety
  Scenario: Handle concurrent migration attempts
    Given multiple processes attempt to migrate simultaneously
    When migrations run concurrently
    Then only one migration should proceed
    And other attempts should wait or fail safely
    And no data corruption should occur

  @database-backup
  Scenario: Create backup before major migrations
    Given I am about to run a significant database migration
    When I initiate the migration process
    Then a backup should be created automatically
    And the backup should be verified as complete
    And migration should only proceed after successful backup

  @connection-pooling
  Scenario: Manage database connection pools effectively
    Given the application uses database connections
    When multiple operations access the database concurrently
    Then connections should be properly pooled
    And no connection leaks should occur
    And performance should be optimized

  @migration-status-tracking
  Scenario: Track migration status and history
    When I check the migration status
    Then I should see which migrations have been applied
    And when each migration was executed
    And any migration failures should be logged
    And the current schema version should be clear