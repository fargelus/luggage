# frozen_string_literal: true

require_relative 'luggage/version'
require_relative 'luggage/helpers'
require_relative 'luggage/options'
require_relative 'luggage/reporter'

module Luggage
  class Error < StandardError; end

  class Tool
    include Options
    include Helpers

    def initialize
      @options = parse_options
      @dir_path = ARGV[0]
      @count = ARGV[1].to_i || 1
      @reporter = Reporter.new(@dir_path, @options)
    end

    def print_report
      @reporter.files = collect_luggage
      @reporter.print
    end

    private

    def collect_luggage
      oldest_files = files_timings(@dir_path).min_by(@count) { |*, timing| timing }
                                             .to_h
      return oldest_files.first(1) if oldest_files.size == 1

      oldest_files.sort_by { |file, *| File.size("#{@dir_path}/#{file}") }
                  .reverse
    end
  end
end

Luggage::Tool.new.print_report
