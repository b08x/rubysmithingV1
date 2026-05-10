# frozen_string_literal: true

require "journald/logger"
require "logger"

module Rubysmithing
  class << self
    def logger
      @logger ||= begin
        log_level = ENV.fetch("LOG_LEVEL", "INFO").upcase
        level = Logger.const_get(log_level) rescue Logger::INFO
        
        # Initialize Journald Logger with the program name
        l = Journald::Logger.new("rubysmithing")
        l.level = level
        l.tag(app: "rubysmithing")
        l
      end
    end

    def logger=(custom_logger)
      @logger = custom_logger
    end
  end
end
