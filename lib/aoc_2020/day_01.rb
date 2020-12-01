# frozen_string_literal: true

module Aoc2020
  #----
  class Day01
    def initialize
      @input = File.read(File.join(Aoc2020::INPUT_FILES, 'day_01.txt')).split.map(&:to_i)
    end

    def part_one
      expense_report(2)
    end

    def part_two
      expense_report(3)
    end

    private

    def expense_report(items)
      @input.sort.combination(items).to_a.each { |a| return a.inject(:*) if a.inject(:+).eql?(2020) }
    end
  end
end
