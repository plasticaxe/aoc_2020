# frozen_string_literal: true

module Aoc2020
  #----
  class DockingData1
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
      @mem   = {}
      @mask  = []
    end

    def sum_of_all
      init_docking_program
      @mem.values.inject(:+)
    end

    private

    def init_docking_program
      @input.each do |i|
        case i
        when /^mask/
          update_mask(i.split.last)
        when /^mem/
          update_mem(i.split.first.gsub(/^mem\[([0-9]+)\]/, '\1'), i.split.last)
        else
          raise 'wut?'
        end
      end
    end

    def update_mask(mask)
      @mask = mask.chars
    end

    def update_mem(loc, num)
      @mem[loc] = bin_to_dec(num_with_mask(num))
    end

    def num_with_mask(num)
      output = []
      dec_to_bin(num).chars.each_with_index do |c, i|
        output << (@mask[i].eql?('X') ? c : @mask[i])
      end
      output.join
    end

    def dec_to_bin(num)
      num.to_i.to_s(2).rjust(36, '0')
    end

    def bin_to_dec(num)
      num.to_i(2)
    end
  end

  #----
  class DockingData2
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
      @mem   = {}
      @mask  = []
    end

    def sum_of_all
      init_docking_program
      @mem.values.inject(:+)
    end

    private

    def init_docking_program
      @input.each do |i|
        case i
        when /^mask/
          update_mask(i.split.last)
        when /^mem/
          update_mem(i.split.first.gsub(/^mem\[([0-9]+)\]/, '\1'), i.split.last)
        else
          raise 'wut?'
        end
      end
    end

    def update_mask(mask)
      @mask = mask.chars
    end

    def update_mem(loc, num)
      memory_locs(loc).each do |this_loc|
        @mem[this_loc] = num.to_i
      end
    end

    def memory_locs(loc)
      locs = [[]]
      dec_to_bin(loc).chars.each_with_index do |c, i|
        case @mask[i]
        when '0'
          locs.each { |l| l.push(c) }
        when '1'
          locs.each { |l| l.push(@mask[i]) }
        when 'X'
          locs = floating_locs(locs)
        end
      end
      locs.map { |l| bin_to_dec(l.join) }
    end

    def floating_locs(locs)
      new_locs = []
      locs.each do |loc|
        new_locs << loc.dup.push('0')
        new_locs << loc.dup.push('1')
      end
      new_locs
    end

    def dec_to_bin(num)
      num.to_i.to_s(2).rjust(36, '0')
    end

    def bin_to_dec(num)
      num.to_i(2)
    end
  end

  #-----
  module Day14
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_14_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_14.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::DockingData1.new(input_file).sum_of_all
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::DockingData2.new(input_file).sum_of_all
    end
  end
end
