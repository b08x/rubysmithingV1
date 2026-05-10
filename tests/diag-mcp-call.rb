# frozen_string_literal: true

require_relative "../plugins/rubysmithing/config/boot"

curator = Rubysmithing::Discovery::GemCurator.new
# Using a more specific query
cheatsheet = curator.generate_cheatsheet(["async"], query: "How do I create a new Async task and wait for it?")

puts "--- FULL CHEATSHEET OUTPUT ---"
puts cheatsheet
puts "--- END OUTPUT ---"
