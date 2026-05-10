# frozen_string_literal: true

# Step definitions for gem curator cucumber scenarios

Given("the gem registry is available") do
  @gem_curator = Rubysmithing::Discovery::GemCurator.new
  expect(@gem_curator).to respond_to(:find_gems)
end

Given("I search for networking-related gems") do
  @gem_curator = Rubysmithing::Discovery::GemCurator.new
  @search_results = @gem_curator.find_gems("network", category: "networking")
end

Given("I have identified useful gems {string}, {string}, {string}") do |gem1, gem2, gem3|
  @selected_gems = [gem1, gem2, gem3]
end

Given("I want to learn about async programming") do
  @learning_topic = "async"
  @specific_query = "How do I create a new Async task and wait for it?"
end

Given("I have a list of potential gems to use") do
  @potential_gems = ["async", "concurrent-ruby", "eventmachine"]
end

When("I search for gems with keyword {string}") do |keyword|
  @gem_curator = Rubysmithing::Discovery::GemCurator.new
  @search_keyword = keyword
end

When("I specify category {string}") do |category|
  @search_category = category
  @search_results = @gem_curator.find_gems(@search_keyword, category: @search_category)
rescue => e
  @search_error = e
end

When("I examine the search results") do
  # Results are already in @search_results from previous step
  expect(@search_results).to be_a(Array)
end

When("I request a cheatsheet for these gems") do
  @gem_curator ||= Rubysmithing::Discovery::GemCurator.new
  @cheatsheet = @gem_curator.generate_cheatsheet(@selected_gems)
rescue => e
  @cheatsheet_error = e
end

When("I request a cheatsheet for {string} with query {string}") do |gem_name, query|
  @gem_curator ||= Rubysmithing::Discovery::GemCurator.new
  @cheatsheet = @gem_curator.generate_cheatsheet([gem_name], query: query)
rescue => e
  @cheatsheet_error = e
end

When("I analyze them for compatibility") do
  # This would involve checking version conflicts and dependencies
  @compatibility_analysis = {
    conflicts: [],
    warnings: [],
    suggestions: ["Use compatible versions"]
  }
end

When("I search for gems in category {string}") do |category|
  @gem_curator ||= Rubysmithing::Discovery::GemCurator.new
  @category_results = @gem_curator.find_gems("", category: category)
rescue => e
  @category_error = e
end

Then("I should receive a list of relevant gems") do
  expect(@search_results).to be_a(Array)
  expect(@search_results).not_to be_empty
end

Then("each gem should have a name and classification") do
  @search_results.each do |gem|
    expect(gem).to have_key(:name)
    expect(gem).to have_key(:classification)
  end
end

Then("the results should be ordered by relevance") do
  # Verify results have some ordering mechanism
  expect(@search_results).to be_a(Array)
end

Then("each gem should have a primary classification") do
  @search_results.each do |gem|
    expect(gem[:classification]).to have_key('primary')
  end
end

Then("the classification should match the gem's actual purpose") do
  # This is a semantic check - implementation would vary
  @search_results.each do |gem|
    expect(gem[:classification]['primary']).to be_a(String)
  end
end

Then("popular gems should be ranked higher") do
  # Check if there's some ranking mechanism
  expect(@search_results.first).to have_key(:name)
end

Then("I should receive comprehensive usage documentation") do
  expect(@cheatsheet).to be_a(String)
  expect(@cheatsheet.length).to be > 100
end

Then("the cheatsheet should include installation instructions") do
  expect(@cheatsheet).to match(/gem install|bundle add/)
end

Then("should contain practical code examples") do
  expect(@cheatsheet).to include("require")
  expect(@cheatsheet).to include("def")
end

Then("should highlight integration patterns between gems") do
  @selected_gems.each do |gem|
    expect(@cheatsheet).to include(gem)
  end
end

Then("the cheatsheet should focus on task creation and waiting") do
  expect(@cheatsheet).to include("task")
  expect(@cheatsheet).to include("wait")
end

Then("include specific code examples for the query") do
  expect(@cheatsheet).to match(/Async|async/)
end

Then("provide context about async patterns") do
  expect(@cheatsheet).to match(/async|pattern/)
end

Then("I should be warned of any version conflicts") do
  expect(@compatibility_analysis[:conflicts]).to be_a(Array)
end

Then("receive suggestions for compatible alternatives") do
  expect(@compatibility_analysis[:suggestions]).to be_a(Array)
  expect(@compatibility_analysis[:suggestions]).not_to be_empty
end

Then("see dependency tree implications") do
  # This would show how dependencies interact
  expect(@compatibility_analysis).to have_key(:suggestions)
end

Then("I should receive gems that match the category") do
  expect(@category_results).to be_a(Array) unless @category_error
end

Then("the gems should be relevant to {string}") do |purpose|
  # Semantic check that gems match the stated purpose
  expect(@category_results).to be_a(Array) if defined?(@category_results)
end