# frozen_string_literal: true

require_relative "../config/boot"

puts "RUBY_GEM_DB_DIR: #{ENV['RUBY_GEM_DB_DIR']}"
puts "Config dir exists: #{Dir.exist?(File.expand_path('~/.config/rubysmithing'))}"
puts "DB dir exists: #{Dir.exist?(ENV['RUBY_GEM_DB_DIR'])}"
