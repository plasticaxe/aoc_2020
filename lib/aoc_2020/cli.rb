# frozen_string_literal: true

require 'thor'

module Aoc2020
  # I don't really know what this is for yet. I'm just trying stuff out.
  class CLI < Thor
    desc 'day_01', 'prints the solutions'
    def day_one
      puts Aoc2020::Day01.new.part_one
      puts Aoc2020::Day01.new.part_two
    end
  end
end
