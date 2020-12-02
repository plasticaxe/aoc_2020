# frozen_string_literal: true

module Aoc2020
  #----
  class Day01
    def initialize
      @input = File.read(File.join(Aoc2020::INPUT_FILES, 'day_01.txt')).split.map(&:to_i)
    end

    def part_one
      expense_report(2, 2020)
    end

    def part_two
      expense_report(3, 2020)
    end

    private

    def expense_report(item_count, total)
      values ||= @input.sort
      sample ||= item_count
      values.first(sample).combination(item_count).to_a.each { |a| return a.inject(:*) if a.inject(:+).eql?(total) }
      raise 'did not find an answer'
    rescue StandardError => e
      sample += 1
      retry if sample <= values.size
      raise e
    end
  end
end
