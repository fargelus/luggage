# frozen_string_literal: true

require 'filesize'

module Luggage
  module Helpers
    def get_pretty_file_size(path)
      bytes = File.size(path)
      Filesize.from("#{bytes} B").pretty.split(' ')
    end
  end
end
