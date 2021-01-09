# frozen_string_literal: true

require_relative 'luggage/version'
require_relative 'luggage/report'
require_relative 'luggage/options'

module Luggage
  class Error < StandardError; end

  class Tool
    include Options

    def initialize
      @options = parse_options
      @dir_path = ARGV[0]
      @count = ARGV[1].to_i || 1
    end

    def collect
      @luggage = collect_luggage
      p @luggage
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

luggage = Luggage::Tool.new
luggage.collect
