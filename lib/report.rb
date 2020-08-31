# frozen_string_literal: true

def get_pretty_file_size(path)
  bytes = File.size(path)
  size = bytes
  measure = ['Kb', 'Mb', 'Gb'].detect do |measure|
    size /= 1024
    (size / 1024).zero?
  end

  measure = '' if size.zero?
  [size, measure]
end

def print_report(dir_path, files)
  spaces = ' ' * 4
  files.each do |file|
    full_path = "#{dir_path}/#{file}"
    file_size, measure = get_pretty_file_size(full_path)
    puts "#{file_size}#{measure}#{spaces}#{file}"
  end
end
