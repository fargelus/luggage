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
      spaces = 15
      puts 'Size'.ljust(spaces) + 'File'
      collect_luggage.each do |file|
        full_path = "#{@dir_path}/#{file}"
        file_size, measure = get_pretty_file_size(full_path)
        puts "#{file_size} #{measure}".ljust(spaces) + file
      end
    end

    private

    def collect_luggage
      oldest_files = get_files_in_dir.min_by(@count) { |file| File.atime("#{@dir_path}/#{file}") }
      return oldest_files.first(1) if oldest_files.size == 1

      oldest_files.sort_by { |file| File.size("#{@dir_path}/#{file}") }
                  .reverse
    end

    def get_files_in_dir
      entries = Dir.entries(@dir_path)
      entries.reject { |e| File.directory?("#{@dir_path}/#{e}") }
    end
  end
end

Luggage::Tool.new.print_report
