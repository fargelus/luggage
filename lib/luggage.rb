#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'luggage/files'

dir_path = ARGV[0]
file = largest_less_used_file(dir_path)
puts file
