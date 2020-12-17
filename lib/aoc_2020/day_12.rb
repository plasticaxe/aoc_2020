# frozen_string_literal: true

include Math

module Aoc2020
  #----
  class RainRisk1
    def initialize(input_file)
      @input       = File.read(input_file).each_line(chomp: true).map { |line| { action: line[0], value: line[1..-1].to_i } }
      @south_north = 0
      @west_east   = 0
      @direction   = 'E'
    end

    def manhattan_distance
      @input.each { |instruction| process_instruction(instruction) }
      @south_north.abs + @west_east.abs
    end

    def process_instruction(instruction)
      case instruction[:action]
      when 'N'
        @south_north += instruction[:value]
      when 'E'
        @west_east += instruction[:value]
      when 'S'
        @south_north -= instruction[:value]
      when 'W'
        @west_east -= instruction[:value]
      when 'F'
        process_instruction(action: @direction, value: instruction[:value])
      when 'R'
        @direction = case @direction
                     when 'N'
                       ['N', 'E', 'S', 'W'][instruction[:value] / 90]
                     when 'E'
                       ['E', 'S', 'W', 'N'][instruction[:value] / 90]
                     when 'S'
                       ['S', 'W', 'N', 'E'][instruction[:value] / 90]
                     when 'W'
                       ['W', 'N', 'E', 'S'][instruction[:value] / 90]
                     end
      when 'L'
        @direction = case @direction
                     when 'N'
                       ['N', 'W', 'S', 'E'][instruction[:value] / 90]
                     when 'E'
                       ['E', 'N', 'W', 'S'][instruction[:value] / 90]
                     when 'S'
                       ['S', 'E', 'N', 'W'][instruction[:value] / 90]
                     when 'W'
                       ['W', 'S', 'E', 'N'][instruction[:value] / 90]
                     end
      end
    end
  end

  #----
  class RainRisk2
    def initialize(input_file)
      @input       = File.read(input_file).each_line(chomp: true).map { |line| { action: line[0], value: line[1..-1].to_i } }
      @boat_sn     = 0
      @boat_we     = 0
      @waypoint_sn = 1
      @waypoint_we = 10
    end

    def manhattan_distance
      @input.each { |instruction| process_instruction(instruction) }
      (@boat_sn.abs + @boat_we.abs).to_i
    end

    def process_instruction(instruction)
      case instruction[:action]
      when 'N'
        @waypoint_sn += instruction[:value]
      when 'E'
        @waypoint_we += instruction[:value]
      when 'S'
        @waypoint_sn -= instruction[:value]
      when 'W'
        @waypoint_we -= instruction[:value]
      when 'F'
        relative_sn = @waypoint_sn - @boat_sn
        relative_we = @waypoint_we - @boat_we
        @boat_sn     += relative_sn * instruction[:value]
        @boat_we     += relative_we * instruction[:value]
        @waypoint_sn += relative_sn * instruction[:value]
        @waypoint_we += relative_we * instruction[:value]
      when 'R'
        radians      = (360 - instruction[:value]) * Math::PI / 180
        cos          = Math.cos(radians)
        sin          = Math.sin(radians)
        x            = @waypoint_we - @boat_we
        y            = @waypoint_sn - @boat_sn
        @waypoint_we = x * cos - y * sin + @boat_we
        @waypoint_sn = x * sin + y * cos + @boat_sn
      when 'L'
        radians      = instruction[:value] * Math::PI / 180
        cos          = Math.cos(radians)
        sin          = Math.sin(radians)
        x            = @waypoint_we - @boat_we
        y            = @waypoint_sn - @boat_sn
        @waypoint_we = x * cos - y * sin + @boat_we
        @waypoint_sn = x * sin + y * cos + @boat_sn
      end
    end
  end

  #-----
  module Day12
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_12.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::RainRisk1.new(input_file).manhattan_distance
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::RainRisk2.new(input_file).manhattan_distance
    end
  end
end
