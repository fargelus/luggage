#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/files'
require_relative 'lib/report'

dir_path, count = ARGV
files = luggage(dir_path, amount: count.to_i)
print_report(dir_path, files)
