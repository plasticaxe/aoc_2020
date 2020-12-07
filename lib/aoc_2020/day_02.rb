# frozen_string_literal: true

module Aoc2020
  #----
  class PasswordPhilosophy
    def initialize(input_file)
      @input = File.read(input_file)
    end

    def validator_one
      parsed_input.count { |h| h[:password].to_s.count(h[:letter]).between?(h[:int_one], h[:int_two]) }
    end

    def validator_two
      parsed_input.count do |h|
        [h[:password][(h[:int_one] - 1)], h[:password][(h[:int_two] - 1)]].count(h[:letter]).eql?(1)
      end
    end

    private

    def parsed_input
      array = []
      @input.each_line(chomp: true) do |line|
        values = line.split(/\W+/)
        array.push(int_one: values[0].to_i, int_two: values[1].to_i, letter: values[2], password: values[3])
      end
      array
    end
  end

  # ----
  module Day02
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_02.txt')
    end

    def self.part_one(input_file = default_input_file)
      PasswordPhilosophy.new(input_file).validator_one
    end

    def self.part_two(input_file = default_input_file)
      PasswordPhilosophy.new(input_file).validator_two
    end
  end
end
