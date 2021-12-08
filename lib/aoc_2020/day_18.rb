# frozen_string_literal: true

module Aoc2020
  #----
  class Day18Part1
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
    end

    def run
      @input.map { |line| evaluate(line) }.inject(:+)
    end

    def evaluate(input)
      # Process parentheses first
      loop do
        input.gsub!(/\(([0-9+* ]*)\)/) do |g|
          eval_left_to_right(g.gsub(/[()]/, ''))
        end
        break if input.match('\(').nil?
      end
      eval_left_to_right(input)
    end

    def eval_left_to_right(input)
      phrases = input.split
      total   = phrases.shift.to_i
      loop do
        operation = phrases.shift
        case operation
        when '+'
          total += phrases.shift.to_i
        when '*'
          total *= phrases.shift.to_i
        end
        break if phrases.empty?
      end
      total
    end
  end

  #----
  class Day18Part2 < Day18Part1
    def evaluate(input)
      # Process parentheses first
      loop do
        input.gsub!(/\(([0-9+* ]*)\)/) { |g| eval_addition_first(g.gsub(/[()]/, '')) }
        break if input.match('\(').nil?
      end
      eval_addition_first(input)
    end

    def eval_addition_first(input)
      # Process addition first
      loop do
        input.gsub!(/([0-9]+ \+ [0-9]+)/) { |g| eval(g) }
        break if input.match(/\+/).nil?
      end
      eval_left_to_right(input)
    end
  end

  #-----
  module Day18
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_18_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_18.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::Day18Part1.new(input_file).run
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::Day18Part2.new(input_file).run
    end
  end
end
