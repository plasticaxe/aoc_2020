# frozen_string_literal: true

require 'thor'

module Aoc2020
  # ---
  class CLI < Thor
    desc 'print_solution', 'takes a day number and input file and prints the solution'
    option :day, required: true, aliases: :d
    option :input_file, required: false, aliases: :i

    def print_solution
      %w[one two].each do |part_num|
        aoc_class = Object.const_get("Aoc2020::Day#{options[:day].rjust(2, '0')}")
        if options[:input_file].nil?
          puts aoc_class.send("part_#{part_num}")
        else
          puts aoc_class.send("part_#{part_num}", options[:input_file])
        end
      end
    end

    default_task :print_solution
  end
end
