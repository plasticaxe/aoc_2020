# frozen_string_literal: true

module Aoc2020
  #----
  class PassportProcessing
    def initialize(input_file)
      @input = File.read(input_file).tr("\n", ' ').split('  ').map { |p| Hash[*p.tr(':', ' ').split] }
    end

    def valid_passports
      @input.count { |passport| all_fields_found?(passport) }
    end

    def all_fields_found?(passport)
      required_fields.map { |field| passport.keys.include?(field) }.inject(:&)
    end

    def valid_and_correct_passports
      @input.count { |passport| all_fields_found?(passport) && all_fields_valid?(passport) }
    end

    def all_fields_valid?(passport)
      required_fields.map { |field| send("valid_field_#{field}?", passport[field]) }.inject(:&)
    end

    def required_fields
      %w[byr iyr eyr hgt hcl ecl pid]
    end

    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    def valid_field_byr?(field)
      field.to_i.between?(1920, 2002)
    end

    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    def valid_field_iyr?(field)
      field.to_i.between?(2010, 2020)
    end

    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    def valid_field_eyr?(field)
      field.to_i.between?(2020, 2030)
    end

    # hgt (Height) - a number followed by either cm or in:
    #   If cm, the number must be at least 150 and at most 193.
    #   If in, the number must be at least 59 and at most 76.
    def valid_field_hgt?(field)
      case field
      when /^[0-9]{3}cm$/
        field.gsub(/cm$/, '').to_i.between?(150, 193)
      when /^[0-9]{2}in$/
        field.gsub(/in$/, '').to_i.between?(59, 76)
      else
        false
      end
    end

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    def valid_field_hcl?(field)
      /^#[0-9a-f]{6}$/.match?(field)
    end

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    def valid_field_ecl?(field)
      %w[amb blu brn gry grn hzl oth].include?(field)
    end

    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    def valid_field_pid?(field)
      /^[0-9]{9}$/.match?(field)
    end
  end

  #----
  module Day04
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_04.txt')
    end

    def self.part_one(input_file = default_input_file)
      PassportProcessing.new(input_file).valid_passports
    end

    def self.part_two(input_file = default_input_file)
      PassportProcessing.new(input_file).valid_and_correct_passports
    end
  end
end
