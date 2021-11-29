# frozen_string_literal: true

Dir.glob(File.join(File.dirname(__FILE__), 'aoc_2020', '*.rb')).each do |f|
  require "aoc_2020/#{File.basename(f, '.rb')}"
end

module Aoc2020
  INPUT_FILES = File.join(__dir__, '..', 'resources', 'input')

  class Error < StandardError; end
end
