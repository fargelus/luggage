# frozen_string_literal: true

require_relative 'luggage/version'
require_relative 'luggage/helpers'
require_relative 'luggage/options'
require_relative 'luggage/reporter'

module Luggage
  class Tool
    include Options
    include Helpers

    def initialize
      @options = parse_options
      @dir_path = ARGV[0]
      @count = ARGV[1].to_i || 1
      @reporter = Reporter.new(@options)
    end

    def print_report
      @reporter.files = @options[:recursive].nil? ? collect_luggage : recursive_luggage
      @reporter.print
    end

    private

    def collect_luggage(dir = @dir_path)
      oldest_files = files_timings(dir).min_by(@count) { |*, timing| timing }
                                       .map { |file, timing| ["#{dir}/#{file}", timing] }
                                       .map { |path, timing| [path.gsub(%r{/{2,}}, '/'), timing] }
      return oldest_files.first(1) if oldest_files.size == 1

      oldest_files
    end

    def recursive_luggage
      child_dirs = Dir.glob("#{@dir_path}/**/")
      all_files = child_dirs.collect { |dir| collect_luggage(dir) }
      all_files.flatten(1)
               .min_by(@count) { |*, timing| timing }
    end
  end
end
