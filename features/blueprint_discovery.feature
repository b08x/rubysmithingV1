Feature: Blueprint Librarian Semantic Discovery
  In order to implement convention-aware architectural code generation
  As the Sovereign Quality Governance system
  I need the Librarian to archive validated code blueprints and retrieve them using semantic natural language search

  Scenario: Archiving and Semantically Searching for a Blueprint
    Given the Librarian system is running
    When I archive a blueprint named "Sequel Async Connection"
    And its description is "A pattern for establishing an asynchronous Sequel connection with pgvector support"
    And I search the Librarian for "How do I connect to postgres using async and vector?"
    Then I should find exactly 1 match
    And the top match should be named "Sequel Async Connection"
    And the match similarity should be above 0.50
