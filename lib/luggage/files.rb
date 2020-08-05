# frozen_string_literal: true

def get_files_in_dir(path)
  entries = Dir.entries(path)
  entries.reject { |e| File.directory?("#{path}/#{e}") }
end

def largest_less_used_file(path, amount: 1)
  files = get_files_in_dir(path)
  files.min_by(amount) { |file| File.atime("#{path}/#{file}") }
  return files.first if files.size == 1

  files.max_by { |file| File.size("#{path}/#{file}") }
end
