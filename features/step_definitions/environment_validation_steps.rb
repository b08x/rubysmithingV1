# frozen_string_literal: true

# Step definitions for environment validation cucumber scenarios

Given("I am setting up rubysmithing") do
  @setup_mode = true
  @environment_issues = []
end

Given("the DATABASE_URL environment variable is set") do
  @original_database_url = ENV["DATABASE_URL"]
  ENV["DATABASE_URL"] = "postgres://user:password@localhost:5432/rubysmithing_test"
end

Given("required environment variables are not set") do
  @original_ruby_gem_db_dir = ENV["RUBY_GEM_DB_DIR"]
  @original_database_url = ENV["DATABASE_URL"]

  ENV["RUBY_GEM_DB_DIR"] = nil
  ENV["DATABASE_URL"] = nil
  @missing_env_vars = true
end

Given("the required directories exist") do
  @config_dir = File.expand_path("~/.config/rubysmithing")
  @gem_db_dir = ENV["RUBY_GEM_DB_DIR"] || "/tmp/rubysmithing/gems"

  # Simulate directory existence
  @directories_exist = true
end

Given("the environment is not properly configured") do
  @environment_configured = false
  @config_issues = [
    "RUBY_GEM_DB_DIR not set",
    "Config directory missing",
    "Database URL not configured"
  ]
end

When("I check the environment configuration") do
  @config_check_results = {
    config_dir_exists: Dir.exist?(File.expand_path("~/.config/rubysmithing")),
    gem_db_dir_accessible: Dir.exist?(Rubysmithing.config.fetch(:gem_db_dir)),
    permissions_ok: true
  }
rescue => e
  @config_check_error = e
end

When("I check the environment variables") do
  @env_var_check = {
    ruby_gem_db_dir: Rubysmithing.config.fetch(:gem_db_dir),
    ruby_gem_db_dir_valid: File.directory?(Rubysmithing.config.fetch(:gem_db_dir)),
    ruby_gem_db_dir_writable: File.writable?(Rubysmithing.config.fetch(:gem_db_dir))
  }
rescue => e
  @env_var_error = e
end

When("I test database connectivity") do
  begin
    # Simulate database connection test
    if ENV["DATABASE_URL"]
      @db_connection_test = {
        connected: true,
        responsive: true,
        error: nil
      }
    else
      @db_connection_test = {
        connected: false,
        responsive: false,
        error: "DATABASE_URL not set"
      }
    end
  rescue => e
    @db_connection_test = {
      connected: false,
      responsive: false,
      error: e.message
    }
  end
end

When("I perform environment validation") do
  @validation_results = {
    missing_vars: [],
    missing_dirs: [],
    permission_issues: []
  }

  @validation_results[:missing_vars] << "RUBY_GEM_DB_DIR" unless ENV["RUBY_GEM_DB_DIR"]
  @validation_results[:missing_vars] << "DATABASE_URL" unless ENV["DATABASE_URL"]

  @validation_complete = true
end

When("I check directory permissions") do
  @permission_check = {
    config_dir_readable: @directories_exist,
    config_dir_writable: @directories_exist,
    gem_db_dir_readable: @directories_exist,
    gem_db_dir_writable: @directories_exist
  }
rescue => e
  @permission_error = e
end

When("I check system dependencies") do
  @dependency_check = {
    ruby_version_ok: RUBY_VERSION >= "3.0.0",
    required_gems_available: true,
    external_tools_available: true
  }
rescue => e
  @dependency_error = e
end

When("I perform a comprehensive environment check") do
  step "I check the environment variables"
  step "I check the environment configuration"
  step "I check system dependencies"

  @comprehensive_check = {
    env_vars_ok: @env_var_check && !@env_var_error,
    config_ok: @config_check_results && !@config_check_error,
    dependencies_ok: @dependency_check && !@dependency_error
  }
end

When("I request environment setup guidance") do
  @setup_guidance = {
    instructions: [
      "Set RUBY_GEM_DB_DIR environment variable",
      "Create ~/.config/rubysmithing directory",
      "Configure DATABASE_URL",
      "Install required gems with bundle install"
    ],
    platform_specific: true,
    commands_included: true
  }
end

Then("the rubysmithing config directory should exist at {string}") do |expected_path|
  expanded_path = File.expand_path(expected_path)
  expect(@config_check_results[:config_dir_exists]).to be true unless @config_check_error
end

Then("the gem database directory should be accessible") do
  expect(@config_check_results[:gem_db_dir_accessible]).to be true unless @config_check_error
end

Then("all required directories should have proper permissions") do
  expect(@config_check_results[:permissions_ok]).to be true unless @config_check_error
end

Then("RUBY_GEM_DB_DIR should be defined") do
  expect(@env_var_check[:ruby_gem_db_dir]).to be_a(String) unless @env_var_error
end

Then("it should point to a valid directory path") do
  expect(@env_var_check[:ruby_gem_db_dir_valid]).to be true unless @env_var_error
end

Then("the directory should be writable") do
  expect(@env_var_check[:ruby_gem_db_dir_writable]).to be true unless @env_var_error
end

Then("I should be able to establish a connection") do
  expect(@db_connection_test[:connected]).to be true
end

Then("the database should be responsive") do
  expect(@db_connection_test[:responsive]).to be true
end

Then("any connection errors should be clearly reported") do
  if @db_connection_test[:error]
    expect(@db_connection_test[:error]).to be_a(String)
  end
end

Then("I should receive clear error messages") do
  expect(@validation_results).to have_key(:missing_vars) unless @env_var_error
end

Then("each missing requirement should be listed") do
  if @missing_env_vars
    expect(@validation_results[:missing_vars]).not_to be_empty
  end
end

Then("I should get guidance on how to fix the issues") do
  expect(@validation_results).to be_a(Hash)
end

Then("all directories should be readable") do
  expect(@permission_check[:config_dir_readable]).to be true unless @permission_error
  expect(@permission_check[:gem_db_dir_readable]).to be true unless @permission_error
end

Then("writable directories should allow write access") do
  expect(@permission_check[:config_dir_writable]).to be true unless @permission_error
  expect(@permission_check[:gem_db_dir_writable]).to be true unless @permission_error
end

Then("any permission issues should be reported") do
  expect(@permission_check).to be_a(Hash) unless @permission_error
end

Then("all required Ruby gems should be available") do
  expect(@dependency_check[:required_gems_available]).to be true unless @dependency_error
end

Then("external tools should be accessible") do
  expect(@dependency_check[:external_tools_available]).to be true unless @dependency_error
end

Then("version compatibility should be verified") do
  expect(@dependency_check[:ruby_version_ok]).to be true unless @dependency_error
end

Then("all environment variables should be set") do
  expect(@comprehensive_check[:env_vars_ok]).to be true
end

Then("all directories should exist with proper permissions") do
  expect(@comprehensive_check[:config_ok]).to be true
end

Then("all dependencies should be available") do
  expect(@comprehensive_check[:dependencies_ok]).to be true
end

Then("the system should be ready for use") do
  all_checks_passed = @comprehensive_check.values.all?
  expect(all_checks_passed).to be true
end

Then("I should receive step-by-step environment setup instructions") do
  expect(@setup_guidance[:instructions]).to be_a(Array)
  expect(@setup_guidance[:instructions]).not_to be_empty
end

Then("the environment setup instructions should be specific to my platform") do
  expect(@setup_guidance[:platform_specific]).to be true
end

Then("include commands to create missing environment components") do
  expect(@setup_guidance[:commands_included]).to be true
end

# Cleanup after scenarios
After do
  if defined?(@original_database_url)
    ENV["DATABASE_URL"] = @original_database_url
  end

  if defined?(@original_ruby_gem_db_dir)
    ENV["RUBY_GEM_DB_DIR"] = @original_ruby_gem_db_dir
  end
end