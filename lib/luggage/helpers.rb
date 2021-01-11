# frozen_string_literal: true

require 'filesize'

module Luggage
  module Helpers
    def get_pretty_file_size(path)
      bytes = File.size(path)
      Filesize.from("#{bytes} B").pretty.split(' ')
    end

    def files_timings(dir)
      get_files_in_dir(dir).each_with_object({}) do |file, h|
        h[file] = File.atime("#{dir}/#{file}")
      end
    end

    def get_files_in_dir(dir)
      Dir.entries(dir)
         .reject { |e| File.directory?("#{dir}/#{e}") }
    end
  end
end
