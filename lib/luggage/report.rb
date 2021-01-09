# frozen_string_literal: true

require 'filesize'

module Luggage
  def get_pretty_file_size(path)
    bytes = File.size(path)
    Filesize.from("#{bytes} B").pretty.split(' ')
  end

  def print_report(dir_path, files)
    spaces = 15
    puts 'Size'.ljust(spaces) + 'File'
    files.each do |file|
      full_path = "#{dir_path}/#{file}"
      file_size, measure = get_pretty_file_size(full_path)
      puts "#{file_size} #{measure}".ljust(spaces) + file
    end
  end
end
