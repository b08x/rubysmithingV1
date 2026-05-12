# Process management for rubysmithing BDD workflow
web: bundle exec puma -C config/puma.rb
sfl: bundle exec rake sfl:processor:start
worker: bundle exec rake jobs:work
guard: bundle exec guard
monitor: bundle exec rake system:monitor