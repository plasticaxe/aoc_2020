# frozen_string_literal: true

# NOTES
#
# def combinations
#   all = joltages[0..-2].map { |j| next_possible_values(j) }.inject(&:product)
#   puts 'got here'
#   all.map(&:flatten).map(&:uniq).select { |a| all_increasing_ints?(a) }.uniq.size
# end

module Aoc2020
  #----
  class AdapterArray
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).map(&:to_i).sort
    end

    def jolt_differences
      jolts = joltages.each_cons(2).map { |x, y| y - x }
      jolts.count(1) * jolts.count(3)
    end

    def combinations(current = 0)
      return 1 if current.eql?(end_state)

      (@combinations ||= {})[current] ||= next_possible_values(current).map { |n| combinations(n) }.inject(:+)
    end

    def next_possible_values(current = 0)
      (@next_possible_values ||= {})[current] ||= joltages.select { |v| v.between?((current + 1), (current + 3)) }
    end

    def joltages
      @joltages ||= @input.unshift(0).push(@input[-1] + 3)
    end

    def end_state
      @end_state ||= joltages[-1]
    end
  end

  #----
  module Day10
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_10.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::AdapterArray.new(input_file).jolt_differences
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::AdapterArray.new(input_file).combinations
    end
  end
end
