# frozen_string_literal: true

require 'thor'

module Aoc2020
  #----
  class CLI < Thor
    desc 'day_01', 'prints the solutions'
    def day_01
      day_01_class = Aoc2020::Day01.new
      puts day_01_class.part_one
      puts day_01_class.part_two
    end
  end
end
