require_relative "luggage/version"
require_relative 'luggage/files'
require_relative 'luggage/report'
require_relative 'luggage/help'


module Luggage
  class Error < StandardError; end

  def main
    %w[-h --help].include?(ARGV[0]) || ARGV.size < 2 ? help : tool
  end

  def tool
    dir_path, count = ARGV
    files = collect_luggage(dir_path, amount: count.to_i)
    print_report(dir_path, files)
  end
end

include Luggage
main
