# frozen_string_literal: true

module Aoc2020
  #----
  class Day19Part1
    def initialize(input_file)
      @input    = File.read(input_file).each_line(chomp: true).to_a.freeze
      @rules    = @input.select { |r| r.match(/^[0-9]/) }.freeze
      @messages = @input.select { |m| m.match(/^[ab]/) }.freeze
    end

    def run
      messages_matching_rule_zero
    end

    def messages_matching_rule_zero
      rule_zero = get_rule('0').gsub(/ /, '')
      @messages.count { |m| m.match?(/^#{rule_zero}$/) }
    end

    def get_rule(rule_number)
      (@get_rule ||= {})[rule_number] ||= begin
        rule = parsed_rules[rule_number]
        loop do
          break unless rule.match(/\d/)
          break if rule.match(/\{.+\}/)

          rule.gsub!(/\d+/) { |r| get_rule(r) }
        end
        rule
      end
    end

    def parsed_rules
      @parsed_rules ||= begin
        rules = {}
        @rules.each { |r| rules[r.split(':')[0].strip] = parse_rule_value(r.split(':')[1]) }
        rules
      end
    end

    def parse_rule_value(rule)
      rule.strip.gsub(/"?/, '').gsub(/(^.+\|.+$)/, '(?:\1)')
    end
  end

  #----
  class Day19Part2 < Day19Part1
    def initialize(input_file)
      super
      update_rule_eight
      update_rule_eleven
    end

    # 8: 42 | 42 8
    def update_rule_eight
      parsed_rules['8'] = "(?:#{get_rule('42')})+"
    end

    # 11: 42 31 | 42 11 31
    def update_rule_eleven
      rule_42 = get_rule('42')
      rule_31 = get_rule('31')
      # I really did try to make a recursive regex :(
      parsed_rules['11'] = "(?:#{1.upto(5).map { |n| "(#{rule_42}){#{n}}(#{rule_31}){#{n}}" }.join('|')})"
    end
  end

  #-----
  module Day19
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_19_part_1_example.txt')
      # File.join(Aoc2020::INPUT_FILES, 'day_19_part_2_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_19.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::Day19Part1.new(input_file).run
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::Day19Part2.new(input_file).run
    end
  end
end
