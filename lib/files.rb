# frozen_string_literal: true

def get_files_in_dir(path)
  entries = Dir.entries(path)
  entries.reject { |e| File.directory?("#{path}/#{e}") }
end

def luggage(path, amount: 1)
  files = get_files_in_dir(path)
  oldest_files = files.min_by(amount) { |file| File.atime("#{path}/#{file}") }
  return oldest_files.first(1) if oldest_files.size == 1

  oldest_files.sort_by { |file| File.size("#{path}/#{file}") }
              .reverse
end
