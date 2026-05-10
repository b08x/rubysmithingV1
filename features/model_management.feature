@model-management
Feature: Language Model Discovery and Validation

  The system discovers, validates, and selects appropriate language models
  for different tasks, with emphasis on cost-effective options that support
  required capabilities.

  Background:
    Given the rubysmithing environment is initialized
    And the RubyLLM model registry is available

  @model-discovery
  Scenario: Discover models from OpenRouter provider
    When I refresh the OpenRouter models list
    Then I should receive a comprehensive list of available models
    And each model should have an ID and capabilities
    And pricing information should be included

  @capability-filtering
  Scenario: Filter models by tool support capability
    Given I have a list of available OpenRouter models
    When I filter for models with "tools" capability
    Then I should only receive models that support function calling
    And the results should include both "tools" and "function_calling" capabilities
    And each model should have clear capability indicators

  @cost-optimization
  Scenario: Find free models with tool support
    Given I need a model that supports tools
    And I want to minimize costs
    When I search for free models with tool support
    Then I should receive models with zero or minimal pricing
    And the models should support function calling
    And they should be sorted by cost (lowest first)

  @fallback-selection
  Scenario: Select fallback model when no free models available
    Given no free models with tool support are available
    When I search for low-cost alternatives
    Then I should receive "flash-lite" or similar cheap models
    And the system should clearly indicate this is a fallback choice
    And the selected model should still support required capabilities

  @model-validation
  Scenario: Validate selected model capabilities
    Given I have selected a model for use
    When I validate the model's capabilities
    Then the model should support all required features
    And I should receive confirmation of capability support
    And any limitations should be clearly documented

  @pricing-analysis
  Scenario: Analyze model pricing for cost-effective selection
    Given I have multiple models that meet my capability requirements
    When I analyze their pricing structures
    Then I should see input and output token costs
    And models should be sortable by cost
    And I should get recommendations for cost optimization

  @provider-comparison
  Scenario Outline: Compare models across different providers
    Given I want to find the best model for "<task_type>"
    When I search across provider "<provider>"
    Then I should receive models suitable for "<task_type>"
    And the models should have appropriate capabilities
    And pricing should be competitive

    Examples:
      | provider   | task_type        |
      | openrouter | code_generation  |
      | openrouter | text_analysis    |
      | openrouter | function_calling |

  @model-health-check
  Scenario: Verify model availability and response
    Given I have selected a model to use
    When I perform a health check on the model
    Then the model should be accessible and responsive
    And I should receive a successful test response
    And any errors should be reported clearly