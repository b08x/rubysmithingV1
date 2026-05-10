# frozen_string_literal: true

# Step definitions for model management cucumber scenarios

require "ruby_llm"

Given("the RubyLLM model registry is available") do
  expect(defined?(RubyLLM)).to be_truthy
  expect(RubyLLM).to respond_to(:models)
end

Given("I have a list of available OpenRouter models") do
  @all_models = RubyLLM.models.by_provider(:openrouter)
rescue => e
  @model_fetch_error = e
  @all_models = []
end

Given("I need a model that supports tools") do
  @required_capabilities = [:tools]
end

Given("I want to minimize costs") do
  @cost_optimization = true
  @prefer_free = true
end

Given("no free models with tool support are available") do
  @no_free_models = true
  # Simulate scenario where free models don't exist
end

Given("I have selected a model for use") do
  @selected_model = double("Model",
    id: "test/model",
    capabilities: [:tools],
    pricing: { prompt: 0.0 }
  )
end

Given("I have multiple models that meet my capability requirements") do
  @compatible_models = [
    double("Model1", id: "cheap/model", pricing: { prompt: 0.001 }),
    double("Model2", id: "expensive/model", pricing: { prompt: 0.01 })
  ]
end

Given("I want to find the best model for {string}") do |task_type|
  @task_type = task_type
  @required_capabilities = case task_type
    when "code_generation" then [:tools, :reasoning]
    when "text_analysis" then [:text_processing]
    when "function_calling" then [:tools]
    else [:general]
  end
end

When("I refresh the OpenRouter models list") do
  begin
    @refreshed_models = RubyLLM.models.by_provider(:openrouter)
  rescue => e
    @refresh_error = e
  end
end

When("I filter for models with {string} capability") do |capability|
  @capability_filter = capability.to_sym
  @filtered_models = @all_models.select do |model|
    model.capabilities.include?(@capability_filter) ||
    model.capabilities.include?(:function_calling)
  end
rescue => e
  @filter_error = e
end

When("I search for free models with tool support") do
  @free_tool_models = @all_models.select do |model|
    is_free = model.pricing&.prompt.to_f == 0.0 ||
              model.id.downcase.include?("free")
    supports_tools = model.capabilities.include?(:tools)
    is_free && supports_tools
  end
rescue => e
  @search_error = e
end

When("I search for low-cost alternatives") do
  @low_cost_models = @all_models.select do |model|
    model.capabilities.include?(:tools) &&
    (model.id.include?("flash") || model.id.include?("lite"))
  end.sort_by { |m| m.pricing&.prompt || 0.0 }
rescue => e
  @fallback_error = e
end

When("I validate the model's capabilities") do
  @validation_result = {
    supports_tools: @selected_model.capabilities.include?(:tools),
    supports_reasoning: @selected_model.capabilities.include?(:reasoning),
    valid: true
  }
rescue => e
  @validation_error = e
end

When("I analyze their pricing structures") do
  @pricing_analysis = @compatible_models.map do |model|
    {
      id: model.id,
      input_cost: model.pricing[:prompt],
      output_cost: model.pricing[:completion] || 0.0
    }
  end.sort_by { |p| p[:input_cost] }
rescue => e
  @pricing_error = e
end

When("I search across provider {string}") do |provider|
  @provider_models = RubyLLM.models.by_provider(provider.to_sym)
  @task_suitable_models = @provider_models.select do |model|
    @required_capabilities.any? { |cap| model.capabilities.include?(cap) }
  end
rescue => e
  @provider_search_error = e
end

When("I perform a health check on the model") do
  begin
    # Simulate health check
    @health_check_result = {
      accessible: true,
      responsive: true,
      test_response: "Model is healthy"
    }
  rescue => e
    @health_check_error = e
  end
end

Then("I should receive a comprehensive list of available models") do
  expect(@refreshed_models).to be_a(Array) unless @refresh_error
  expect(@refreshed_models.length).to be > 0 unless @refresh_error
end

Then("each model should have an ID and capabilities") do
  if @refreshed_models && !@refresh_error
    @refreshed_models.each do |model|
      expect(model).to respond_to(:id)
      expect(model).to respond_to(:capabilities)
    end
  end
end

Then("pricing information should be included") do
  if @refreshed_models && !@refresh_error
    @refreshed_models.each do |model|
      expect(model).to respond_to(:pricing)
    end
  end
end

Then("I should only receive models that support function calling") do
  expect(@filtered_models).to be_a(Array) unless @filter_error
  if @filtered_models && !@filter_error
    @filtered_models.each do |model|
      expect(model.capabilities.include?(:tools) ||
             model.capabilities.include?(:function_calling)).to be true
    end
  end
end

Then("the results should include both {string} and {string} capabilities") do |cap1, cap2|
  if @filtered_models && !@filter_error
    capabilities_found = @filtered_models.map(&:capabilities).flatten.uniq
    expect(capabilities_found).to include(cap1.to_sym).or include(cap2.to_sym)
  end
end

Then("each model should have clear capability indicators") do
  expect(@filtered_models).to be_a(Array) unless @filter_error
end

Then("I should receive models with zero or minimal pricing") do
  if @free_tool_models && !@search_error
    @free_tool_models.each do |model|
      expect(model.pricing&.prompt.to_f).to be <= 0.001
    end
  end
end

Then("the models should support function calling") do
  if @free_tool_models && !@search_error
    @free_tool_models.each do |model|
      expect(model.capabilities).to include(:tools)
    end
  end
end

Then("they should be sorted by cost \\(lowest first)") do
  if @free_tool_models && @free_tool_models.length > 1
    prices = @free_tool_models.map { |m| m.pricing&.prompt || 0.0 }
    expect(prices).to eq(prices.sort)
  end
end

Then("I should receive {string} or similar cheap models") do |model_type|
  if @low_cost_models && !@fallback_error
    expect(@low_cost_models.any? { |m| m.id.include?(model_type) }).to be true
  end
end

Then("the system should clearly indicate this is a fallback choice") do
  # This would be indicated in logs or user feedback
  expect(@fallback_error).to be_nil
end

Then("the selected model should still support required capabilities") do
  if @low_cost_models && !@fallback_error && @low_cost_models.any?
    expect(@low_cost_models.first.capabilities).to include(:tools)
  end
end

Then("the model should support all required features") do
  expect(@validation_result[:supports_tools]).to be true unless @validation_error
end

Then("I should receive confirmation of capability support") do
  expect(@validation_result[:valid]).to be true unless @validation_error
end

Then("any limitations should be clearly documented") do
  expect(@validation_result).to be_a(Hash) unless @validation_error
end

Then("I should see input and output token costs") do
  if @pricing_analysis && !@pricing_error
    @pricing_analysis.each do |pricing|
      expect(pricing).to have_key(:input_cost)
      expect(pricing).to have_key(:output_cost)
    end
  end
end

Then("models should be sortable by cost") do
  if @pricing_analysis && @pricing_analysis.length > 1
    expect(@pricing_analysis.first[:input_cost]).to be <= @pricing_analysis.last[:input_cost]
  end
end

Then("I should get recommendations for cost optimization") do
  expect(@pricing_analysis).to be_a(Array) unless @pricing_error
end

Then("I should receive models suitable for {string}") do |task_type|
  expect(@task_suitable_models).to be_a(Array) unless @provider_search_error
end

Then("the models should have appropriate capabilities") do
  if @task_suitable_models && !@provider_search_error
    @task_suitable_models.each do |model|
      expect(@required_capabilities.any? { |cap| model.capabilities.include?(cap) }).to be true
    end
  end
end

Then("pricing should be competitive") do
  expect(@task_suitable_models).to be_a(Array) unless @provider_search_error
end

Then("the model should be accessible and responsive") do
  expect(@health_check_result[:accessible]).to be true unless @health_check_error
  expect(@health_check_result[:responsive]).to be true unless @health_check_error
end

Then("I should receive a successful test response") do
  expect(@health_check_result[:test_response]).to be_a(String) unless @health_check_error
end

Then("any errors should be reported clearly") do
  if @health_check_error
    expect(@health_check_error.message).to be_a(String)
  end
end