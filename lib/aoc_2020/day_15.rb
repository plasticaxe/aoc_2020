# frozen_string_literal: true

module Aoc2020
  #----
  class RambunctiousRecitation
    def initialize(input_file)
      @input       = File.read(input_file).each_line(chomp: true).to_a[0].split(',').map(&:to_i)
      @record      = {}
      @turn        = 0
      @last_spoken = 0
      starting_numbers
    end

    def starting_numbers
      @input.each do |n|
        @turn += 1
        (@record[n] ||= []).push(@turn)
        @last_spoken = n
      end
      puts "starting numbers @record = #{@record}, @turn = #{@turn}"
    end

    def number_spoken(end_turn)
      loop do
        @turn += 1
        # puts "@turn = #{@turn}, @record[#{@last_spoken}] = #{@record[@last_spoken]}"
        if @record[@last_spoken].to_a.size < 2
          @last_spoken = 0
        else
          @last_spoken = @record[@last_spoken][-1] - @record[@last_spoken][-2]
        end
        (@record[@last_spoken] ||= []).push(@turn)
        return @last_spoken if @turn == end_turn
      end
    end
  end

  #-----
  module Day15
    def self.default_input_file
      # Expected answer for example: 1836
      # File.join(Aoc2020::INPUT_FILES, 'day_15_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_15.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::RambunctiousRecitation.new(input_file).number_spoken(2020)
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::RambunctiousRecitation.new(input_file).number_spoken(30_000_000)
    end
  end
end
