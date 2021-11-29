# frozen_string_literal: true

module Aoc2020
  #----
  class TicketTranslation
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
    end

    def error_rate
      count = 0
      nearby_tickets.each do |t|
        t.split(',').each { |n| count += n.to_i unless number_in_rules?(n) }
      end
      count
    end

    def number_in_rules?(number, array_of_rules = all_rules.values)
      array_of_rules.each do |rules|
        return true if rules.map { |r| !r.index(number).nil? }.inject(:|)
      end
      false
    end

    def all_rules
      @all_rules ||= begin
                       rules = {}
                       @input.each do |i|
                         # End of rules
                         break if i.to_s.empty?
                         rule_name        = i.to_s.split(':').first
                         rules[rule_name] = []
                         i.to_s.split(':').last.to_s.split('or').each(&:strip).each do |r|
                           rules[rule_name] << r.split('-')[0].to_i.upto(r.split('-')[1].to_i).to_a.map(&:to_s)
                         end
                       end
                       puts "rules.size = #{rules.size}"
                       rules
                     end
    end

    def nearby_tickets
      @nearby_tickets ||= @input[(@input.index('nearby tickets:') + 1)..-1]
    end

    # Part 2

    def departure_values
      puts "your_ticket = #{your_ticket}"
      values = []
      indexed_fields.each_pair do |index, rule_name|
        values << your_ticket[index].to_i if rule_name.match(/^departure/)
      end
      values.inject(:*)
    end

    def indexed_fields
      @indexed_fields ||= begin
                            fields    = {}
                            rule_set  = all_rules.dup
                            loop do
                              0.upto(all_rules.size - 1).map do |index|
                                next unless fields.keys.index(index).nil?
                                matched = matched_rules(tickets_at_index(index), rule_set)
                                if matched.size.eql?(1)
                                  fields[index] = matched[0]
                                  rule_set.delete(matched[0])
                                  puts "matched #{matched[0]}, remaining rules: #{rule_set.keys}"
                                  return fields if rule_set.empty?
                                end
                              end
                            end
                          end
    end

    def tickets_at_index(index)
      (@tickets_at_index ||= {})[index] ||= valid_nearby_tickets.map { |t| t[index] }
    end

    def matched_rules(ticket_values, rule_set)
      matched = []
      rule_set.each_pair do |rule_name, rule_values|
        next unless ticket_values.map { |n| number_in_rules?(n, rule_values) }.inject(:&)
        matched << rule_name
      end
      matched
    end

    def valid_nearby_tickets
      @valid_nearby_tickets ||= begin
                                  valid_tickets = []
                                  nearby_tickets.each { |t| valid_tickets.push(t.split(',').map(&:strip)) if all_numbers_in_rules?(t.split(',')) }
                                  puts "valid_tickets[0].size = #{valid_tickets[0].size}"
                                  valid_tickets
                                end
    end

    def all_numbers_in_rules?(numbers)
      numbers.each { |n| return false unless number_in_rules?(n) }
      true
    end

    def your_ticket
      @your_ticket ||= @input[(@input.index('your ticket:') + 1)].split(',').map(&:strip)
    end
  end

  #-----
  module Day16
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_16_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_16.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::TicketTranslation.new(input_file).error_rate
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::TicketTranslation.new(input_file).departure_values
    end
  end
end
