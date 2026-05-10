# frozen_string_literal: true

require_relative "../plugins/rubysmithing/config/boot"

curator = Rubysmithing::Discovery::GemCurator.new
gems = curator.find_gems("async", category: "async_networking_orchestration")

puts "Found #{gems.size} gems"
gems.first(3).each do |gem|
  puts "- #{gem[:name]}: #{gem[:classification]['primary']}"
end

cheatsheet = curator.generate_cheatsheet(["async", "httpx", "sequel"])
puts "\nGenerated Cheatsheet (first 200 chars):"
puts cheatsheet[0..200]
