# frozen_string_literal: true

module Aoc2020
  #----
  class Work
    def initialize(input_file)
      @input = File.read(input_file)
    end
  end

  #----
  module DayXX
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_XX.txt')
    end

    def self.part_one(input_file = default_input_file)
      # ----
    end

    def self.part_two(input_file = default_input_file)
      # ----
    end
  end
end
