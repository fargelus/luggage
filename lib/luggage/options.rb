# frozen_string_literal: true

require 'optparse'

module Luggage
  module Options
    def parse_options
      options = {}
      opt_parser = OptionParser.new do |opts|
        opts.banner = options_banner

        opts.on('-r', '--recursive', '-R', 'Search files recursively') do
          options[:recursive] = true
        end

        opts.on('--sort=[size|time]', 'Sort output files with given param') do |sort_type|
          # TODO
          exit(0) unless %w[size time].include? sort_type

          options[:sort] = sort_type
        end

        opts.on('-h', '--help', 'Prints help') do
          help!(opts)
        end
      end

      opt_parser.parse!
      help!(opt_parser) if ARGV.size < 2

      options
    rescue OptionParser::InvalidOption
      help!(opt_parser)
    end

    def help!(options)
      puts options
      exit
    end

    def options_banner
      "luggage(lge)' - is the small cli-tool which goal is to find less used heavy files.\n"\
      "Usage: lge [options] <path> <amount of files>\n"\
      'Options:'
    end
  end
end
