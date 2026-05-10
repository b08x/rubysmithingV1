# frozen_string_literal: true

require_relative "../config/boot"

puts "Migrating database: #{ENV['DATABASE_URL']}"
begin
  if DB
    Rubysmithing::Database.migrate(DB)
    puts "Migration complete."
  else
    puts "Database connection not established. Check your DATABASE_URL."
  end
rescue => e
  puts "Migration failed: #{e.message}"
  puts e.backtrace.first(10)
end
