# frozen_string_literal: true

require_relative 'helpers'

module Luggage
  class Reporter
    include Helpers

    attr_reader :spaces; private :spaces
    attr_writer :files

    def initialize(options)
      @options = options
    end

    def print
      exit(0) if @files.empty?

      @spaces = @files.max_by { |file, *| file.size }.first.size + 5
      header
      return default_print if @options[:sort].nil? || @options[:sort] == 'size'

      sorted_by_time_print
    end

    private

    def default_spaces
      20
    end

    def header
      puts 'Size'.ljust(default_spaces) + 'File'.ljust(spaces) + 'Used'
    end

    def default_print
      @files.each do |file, timing|
        print_row(file, timing)
      end
    end

    def print_row(file, timing)
      file_size, measure = get_pretty_file_size(file)
      time_without_zone = timing.strftime('%d %b %Y %H:%M:%S')
      puts "#{file_size} #{measure}".ljust(default_spaces) + file.ljust(spaces) + time_without_zone
    end

    def sorted_by_time_print
      @files.sort_by { |*, timing| timing }.each do |file, timing|
        print_row(file, timing)
      end
    end
  end
end
