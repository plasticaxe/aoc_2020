# frozen_string_literal: true

module Aoc2020
  #----
  class HandheldHalting
    def initialize(input_file)
      @instructions = File.read(input_file).each_line(chomp: true).map do |line|
        { operation: line.split[0], argument: line.split[1].to_i, counter: 0 }
      end
      @accumulator  = 0
      @pointer      = 0
    end

    def value_before_loop
      loop { looping? ? break : run_next_instruction }
      @accumulator
    end

    def find_the_flaw
      %w[nop jmp].permutation.each do |perm|
        operation_indexes(perm[0]).each do |index|
          switch_operations(index, perm[0], perm[1]) do
            loop do
              return @accumulator if terminated?
              looping? ? break : run_next_instruction
            end
          end
        end
      end
    end

    private

    def looping?
      @instructions[@pointer][:counter].positive?
    end

    def terminated?
      @pointer.eql?(@instructions.size)
    end

    def switch_operations(index, original_op, switched_op)
      @instructions[index][:operation] = switched_op
      yield
      reset_system
      @instructions[index][:operation] = original_op
    end

    def run_next_instruction
      @instructions[@pointer][:counter] += 1
      send "run_#{@instructions[@pointer][:operation]}"
    end

    def run_acc
      @accumulator += @instructions[@pointer][:argument]
      @pointer     += 1
    end

    def run_jmp
      @pointer += @instructions[@pointer][:argument]
    end

    def run_nop
      @pointer += 1
    end

    def operation_indexes(operation)
      @instructions.each_index.select { |i| @instructions[i][:operation].eql?(operation) }
    end

    def reset_system
      @instructions.each { |i| i[:counter] = 0 }
      @accumulator = 0
      @pointer     = 0
    end
  end

  #----
  module Day08
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_08.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::HandheldHalting.new(input_file).value_before_loop
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::HandheldHalting.new(input_file).find_the_flaw
    end
  end
end
