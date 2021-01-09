# frozen_string_literal: true

module Luggage
  def help
    puts "'luggage(lge)' - is the small cli-tool which goal is "\
          'to find less used heavy files.'

    puts 'Usage: lge [options] <path> <amount of files>'

    puts "\n"
    puts "Options:\n"
    spaces = ' ' * 3
    options = {
      '-r': 'search files recursively',
      '--sort=[size, time]': 'sort output files with given param'
    }
    options.each do |opt, desc|
      puts "#{spaces}#{opt}".ljust(25) + desc
    end

    puts "\n"
    puts "Examples:\n"\
         "#{spaces}lge /home 1 - Print most heavy file that was touched long time ago.\n"\
         "#{spaces}lge /usr/bin 5 - Print first five most heavy of the less used files."
  end
end
