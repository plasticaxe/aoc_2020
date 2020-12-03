# frozen_string_literal: true

module Aoc2020
  #----
  class TreeFinder
    def initialize(input_file)
      @map_of_slopes = File.read(input_file).each_line(chomp: true).map { |i| i.chars * 100 }
      @current_x     = 0
      @current_y     = 0
    end

    def trees_found(change_x, change_y)
      trees_found = 0
      loop do
        move_position(change_x, change_y)
        return trees_found if reached_bottom?

        add_more_slopes
        trees_found += 1 if tree_here?
      end
    end

    private

    def move_position(change_x, change_y)
      @current_x += change_x
      @current_y += change_y
    end

    def tree_here?
      @map_of_slopes[@current_y][@current_x].eql?('#')
    end

    def reached_bottom?
      @map_of_slopes[@current_y].nil?
    end

    def add_more_slopes
      return unless @map_of_slopes[@current_y][@current_x].nil?

      @map_of_slopes[@current_y] = [@map_of_slopes[@current_y], @map_of_slopes[@current_y]].flatten
    end
  end

  #----
  module Day03
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_03.txt')
    end

    def self.part_one(input_file = default_input_file)
      TreeFinder.new(input_file).trees_found(3, 1)
    end

    def self.part_two(input_file = default_input_file)
      [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |c|
        TreeFinder.new(input_file).trees_found(c[0], c[1])
      end.inject(:*)
    end
  end
end
