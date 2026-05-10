@gem-curator
Feature: Gem Discovery and Curation

  The Gem Curator discovers relevant gems for development needs and generates
  comprehensive cheatsheets with usage patterns and best practices.

  Background:
    Given the rubysmithing environment is initialized
    And the gem registry is available

  @gem-discovery
  Scenario: Find gems by category and keyword
    When I search for gems with keyword "async"
    And I specify category "async_networking_orchestration"
    Then I should receive a list of relevant gems
    And each gem should have a name and classification
    And the results should be ordered by relevance

  @gem-classification
  Scenario: Gems are properly classified by primary purpose
    Given I search for networking-related gems
    When I examine the search results
    Then each gem should have a primary classification
    And the classification should match the gem's actual purpose
    And popular gems should be ranked higher

  @cheatsheet-generation
  Scenario: Generate usage cheatsheet for multiple gems
    Given I have identified useful gems "async", "httpx", "sequel"
    When I request a cheatsheet for these gems
    Then I should receive comprehensive usage documentation
    And the cheatsheet should include installation instructions
    And should contain practical code examples
    And should highlight integration patterns between gems

  @targeted-cheatsheet
  Scenario: Generate cheatsheet with specific query
    Given I want to learn about async programming
    When I request a cheatsheet for "async" with query "How do I create a new Async task and wait for it?"
    Then the cheatsheet should focus on task creation and waiting
    And include specific code examples for the query
    And provide context about async patterns

  @gem-compatibility
  Scenario: Check gem compatibility and conflicts
    Given I have a list of potential gems to use
    When I analyze them for compatibility
    Then I should be warned of any version conflicts
    And receive suggestions for compatible alternatives
    And see dependency tree implications

  @category-filtering
  Scenario Outline: Find gems by different categories
    When I search for gems in category "<category>"
    Then I should receive gems that match the category
    And the gems should be relevant to "<purpose>"

    Examples:
      | category                     | purpose                |
      | web_frameworks              | building web apps      |
      | testing_tools               | test automation        |
      | database_integration        | data persistence       |
      | async_networking_orchestration | concurrent programming |