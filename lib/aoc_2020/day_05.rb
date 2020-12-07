# frozen_string_literal: true

module Aoc2020
  #----
  class BinaryBoarding
    def initialize(input_file)
      @input = File.read(input_file).each_line.map { |line| { row: line.chars[0..6], col: line.chars[7..9] } }
    end

    def highest_seat_id
      all_seat_ids.max
    end

    def available_seat
      available = (all_seat_ids.min..all_seat_ids.max).to_a - all_seat_ids
      return available.first unless available.size > 1

      raise 'found more than one available seat!'
    end

    private

    def all_seat_ids
      @input.map do |s|
        row = converted_binary(s[:row], 'F', 'B')
        col = converted_binary(s[:col], 'L', 'R')
        (row * 8) + col
      end.sort
    end

    def converted_binary(array, zero_char, one_char)
      array.map { |v| v.tr(zero_char, '0').tr(one_char, '1') }.join.to_i(2)
    end
  end

  #----
  module Day05
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_05.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::BinaryBoarding.new(input_file).highest_seat_id
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::BinaryBoarding.new(input_file).available_seat
    end
  end
end
