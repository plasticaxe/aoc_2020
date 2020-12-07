# frozen_string_literal: true

module Aoc2020
  #----
  class HandyHaversacks
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
    end

    def unique_bags(containing_color)
      bags_containing(containing_color).uniq.size
    end

    def bags_containing(bag_color)
      found_bags = []
      @input.select { |b| b =~ /[0-9] #{bag_color} bag/ }.each do |f|
        parent_bag = f.split.first(2).join(' ')
        found_bags << parent_bag
        found_bags |= bags_containing(parent_bag)
      end
      found_bags
    end

    def individual_bags_required(bag_color)
      count = 0
      @input.select { |b| b =~ /^#{bag_color} bags contain.*/ }.reject { |b| b =~ /no other/ }.each do |rule_list|
        parsed_rules(rule_list).each do |bag_rule|
          multiplier = parsed_multiplier(bag_rule)
          count += multiplier
          count += multiplier * individual_bags_required(parsed_required_bag(bag_rule))
        end
      end
      count
    end

    def parsed_rules(rule_list)
      rule_list.gsub(/.*bags contain /, '').gsub(/bags?/, '').tr('.', '').split(',').map(&:strip)
    end

    def parsed_multiplier(bag_rule)
      bag_rule.split.first.to_i
    end

    def parsed_required_bag(bag_rule)
      bag_rule.split.last(2).join(' ')
    end
  end

  #----
  module Day07
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_07.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::HandyHaversacks.new(input_file).unique_bags('shiny gold')
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::HandyHaversacks.new(input_file).individual_bags_required('shiny gold')
    end
  end
end
