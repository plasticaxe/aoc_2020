# frozen_string_literal: true

module Aoc2020
  #----
  class TobogganTrajectory
    def initialize(input_file)
      @map_of_slopes = File.read(input_file).each_line(chomp: true).map(&:chars)
      @slope_width   = @map_of_slopes[0].size
      @current_x     = 0
      @current_y     = 0
    end

    def trees_found(change_x, change_y)
      trees_found = 0
      loop do
        move_position(change_x, change_y)
        return trees_found if reached_bottom?

        trees_found += 1 if tree_here?
      end
    end

    private

    def move_position(change_x, change_y)
      @current_x = (@current_x + change_x) % @slope_width
      @current_y += change_y
    end

    def tree_here?
      @map_of_slopes[@current_y][@current_x].eql?('#')
    end

    def reached_bottom?
      @map_of_slopes[@current_y].nil?
    end
  end

  #----
  module Day03
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_03.txt')
    end

    def self.part_one(input_file = default_input_file)
      TobogganTrajectory.new(input_file).trees_found(3, 1)
    end

    def self.part_two(input_file = default_input_file)
      [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |c|
        TobogganTrajectory.new(input_file).trees_found(c[0], c[1])
      end.inject(:*)
    end
  end
end
