# frozen_string_literal: true

module Aoc2020
  #----
  class EncodingError
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).map(&:to_i)
    end

    def first_illegal_entry
      25.upto(@input.size - 1) do |pointer|
        return @input[pointer] unless valid_at_index?(pointer)
      end
    end

    def valid_at_index?(pointer)
      @input[(pointer - 25)..(pointer - 1)].combination(2).map(&:sum).include?(@input[pointer])
    end

    def encryption_weakness(target: first_illegal_entry)
      total = 0
      (start_index ||= 0).upto(@input.size - 1) do |pointer|
        total += @input[pointer]
        raise if total > target

        return (@input[start_index..pointer].min + @input[start_index..pointer].max) if total.eql?(target)
      end
    rescue StandardError
      start_index += 1
      raise 'out of bounds' if start_index.eql?(@input.size)

      retry
    end
  end

  #----
  module Day09
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_09.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::EncodingError.new(input_file).first_illegal_entry
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::EncodingError.new(input_file).encryption_weakness
    end
  end
end
