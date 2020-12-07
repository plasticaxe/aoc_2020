# frozen_string_literal: true

module Aoc2020
  #----
  class ReportRepair
    def initialize(input_file)
      @input = File.read(input_file).split.map(&:to_i)
    end

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

  #-----
  module Day01
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_01.txt')
    end

    def self.part_one(input_file = default_input_file)
      ReportRepair.new(input_file).expense_report(2, 2020)
    end

    def self.part_two(input_file = default_input_file)
      ReportRepair.new(input_file).expense_report(3, 2020)
    end
  end
end
