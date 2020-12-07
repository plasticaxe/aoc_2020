# frozen_string_literal: true

module Aoc2020
  #----
  class CustomCustoms
    def initialize(input_file)
      @input = File.read(input_file).tr("\n", ' ').split('  ').map { |g| g.split.map(&:chars) }
    end

    def unique_per_group
      @input.map { |g| g.flatten.uniq.size }.inject(:+)
    end

    def common_per_group
      @input.map { |g| g.inject(:&).size }.inject(:+)
    end
  end

  #----
  module Day06
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_06.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::CustomCustoms.new(input_file).unique_per_group
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::CustomCustoms.new(input_file).common_per_group
    end
  end
end
