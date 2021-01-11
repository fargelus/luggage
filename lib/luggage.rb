# frozen_string_literal: true

require_relative 'luggage/version'
require_relative 'luggage/helpers'
require_relative 'luggage/options'

module Luggage
  class Error < StandardError; end

  class Tool
    include Options
    include Helpers

    def initialize
      @options = parse_options
      @dir_path = ARGV[0]
      @count = ARGV[1].to_i || 1
    end

    def print_report
      luggage = collect_luggage
      exit(0) if luggage.empty?

      spaces = luggage.max_by { |file, *| file.size }.first.size + 5
      puts 'Size'.ljust(spaces) + 'File'.ljust(spaces) + 'Used'

      luggage.each do |file, timing|
        full_path = "#{@dir_path}/#{file}"
        file_size, measure = get_pretty_file_size(full_path)
        time_without_zone = timing.strftime('%d %b %Y %H:%M:%S')
        puts "#{file_size} #{measure}".ljust(spaces) + file.ljust(spaces) + time_without_zone
      end
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
