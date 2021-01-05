# frozen_string_literal: true

def help
  puts "'luggage(lge)' - is the small cli-tool which goal is "\
        "to find less used heavy files."

  puts 'Usage: lge [options] <path> <amount of files>'

  puts "\n"
  puts "Options:\n"
  puts "-r\t search files recursively\n"\
       "--sort=[size, time]\t sort output files with given param"

  puts "\n"
  puts "Examples:\n"\
       "   lge /home 1 - Print most heavy file that was touched long time ago.\n"\
       "   lge /usr/bin 5 - Print first five most heavy of the less used files."
end
