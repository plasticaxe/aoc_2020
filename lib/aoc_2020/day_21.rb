# frozen_string_literal: true

module Aoc2020
  #----
  class Day21Part1
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true)
    end

    def run
      # ---
    end
  end

  #----
  class Day21Part2
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true)
    end

    def run
      # ---
    end
  end

  #-----
  module Day21
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_21_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_21.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::Day21Part1.new(input_file).run
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::Day21Part2.new(input_file).run
    end
  end
end
