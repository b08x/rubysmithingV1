# Rubysmithing Backlog

## Immediate Next Steps

### 1. Resolve Builder Agent Tool Registration
**Issue:** The `Builder` agent scenarios are failing, likely due to an `ArgumentError` or naming conflict when registering `BlueprintSearchTool` within the `RubyLLM::Agent` DSL.
**Task:** 
- Verify the tool registration pattern in `lib/rubysmithing/agents/builder.rb`.
- Ensure the `execute` method signature and `param` declarations perfectly match `RubyLLM` expectations.
- Run `bundle exec cucumber features/builder_agent.feature` to validate.

### 2. Fix Invalid Gemfile Failure
**Issue:** `Scenario: Test invalid Gemfile bundle install` is failing in `features/gem_verification.feature`.
**Task:**
- Inspect the output of `Rubysmithing::BundleTester.test_gemfile_safe` when given a non-existent gem.
- Update the step definition in `features/step_definitions/gem_verification_steps.rb` to correctly assert against the captured Bundler error message.

### 3. Migrate Environment Validation Steps
**Issue:** `features/step_definitions/environment_validation_steps.rb` still checks raw `ENV` variables.
**Task:**
- Refactor the steps to verify keys within `Rubysmithing.config` (e.g., `:gem_db_dir`, `:database_url`).
- Ensure the `Given` steps properly mock or set these config values using `Rubysmithing.configure`.
