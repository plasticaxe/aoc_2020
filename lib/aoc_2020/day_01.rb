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

    def expense_report(item_count)
      values      ||= @input.sort
      sample_size ||= item_count
      values.first(sample_size).combination(item_count).to_a.each { |a| return a.inject(:*) if a.inject(:+).eql?(2020) }
      raise 'did not find an answer'
    rescue StandardError => e
      sample_size += 1
      retry if sample_size <= values.size
      raise e
    end
  end
end
