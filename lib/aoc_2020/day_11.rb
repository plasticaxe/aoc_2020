# frozen_string_literal: true

module Aoc2020
  #----
  class SeatingSystem
    def initialize(input_file)
      @seats = File.read(input_file).each_line(chomp: true).map { |line| line.chars }
    end

    def stabilised_occupied_seats(including_visible = false)
      loop do
        modified_seats = @seats.map(&:clone)
        @seats.each_index do |row|
          @seats[row].each_index do |col|
            case @seats[row][col]
            when 'L'
              if including_visible
                modified_seats[row][col] = '#' if visible_seats_empty?(row, col)
              else
                modified_seats[row][col] = '#' if adjacent_seats_empty?(row, col)
              end
            when '#'
              if including_visible
                modified_seats[row][col] = 'L' if visible_seats_occupied?(row, col)
              else
                modified_seats[row][col] = 'L' if adjacent_seats_occupied?(row, col)
              end
            end
          end
        end
        return count_occupied_seats if modified_seats.eql?(@seats)
        @seats = modified_seats.map(&:clone)
      end
    end

    def adjacent_seats_empty?(row, col)
      adjacent_seats_status(row, col).count('#').zero?
    end

    def adjacent_seats_occupied?(row, col)
      adjacent_seats_status(row, col).count('#') >= 4
    end

    def adjacent_seats_status(row, col)
      array = []
      (row - 1).upto(row + 1).select { |n| n >= 0 }.each do |r|
        (col - 1).upto(col + 1).select { |n| n >= 0 }.each do |c|
          next if [row, col].eql?([r, c]) || @seats[r].nil? || @seats[r][c].nil?
          array << @seats[r][c]
        end
      end
      array
    end

    def visible_seats_empty?(row, col)
      visible_seats_status(row, col).count('#').zero?
    end

    def visible_seats_occupied?(row, col)
      visible_seats_status(row, col).count('#') >= 5
    end

    def visible_seats_status(row, col)
      array = []
      # N
      array << (row - 1).downto(0).map { |r| @seats[r][col] }.reject { |x| x.eql?('.') }.first
      # E
      array << (col + 1).upto(@seats[row].length - 1).map { |c| @seats[row][c] }.reject { |x| x.eql?('.') }.first
      # S
      array << (row + 1).upto(@seats.size - 1).map { |r| @seats[r][col] }.reject { |x| x.eql?('.') }.first
      # W
      array << (col - 1).downto(0).map { |c| @seats[row][c] }.reject { |x| x.eql?('.') }.first
      # NE
      r = row
      c = col
      loop do
        r -= 1
        c += 1
        break if r < 0
        break if @seats[r].nil? || @seats[r][c].nil?
        next unless ['#', 'L'].include?(@seats[r][c])
        array << @seats[r][c]
        break
      end
      # SE
      r = row
      c = col
      loop do
        r += 1
        c += 1
        break if @seats[r].nil? || @seats[r][c].nil?
        next unless ['#', 'L'].include?(@seats[r][c])
        array << @seats[r][c]
        break
      end
      # SW
      r = row
      c = col
      loop do
        r += 1
        c -= 1
        break if c < 0
        break if @seats[r].nil? || @seats[r][c].nil?
        next unless ['#', 'L'].include?(@seats[r][c])
        array << @seats[r][c]
        break
      end
      # NW
      r = row
      c = col
      loop do
        r -= 1
        c -= 1
        break if r < 0 || c < 0
        break if @seats[r].nil? || @seats[r][c].nil?
        next unless ['#', 'L'].include?(@seats[r][c])
        array << @seats[r][c]
        break
      end
      # END
      array
    end

    def count_occupied_seats
      @seats.map { |row| row.count('#') }.sum
    end
  end

  #----
  module Day11
    def self.default_input_file
      File.join(Aoc2020::INPUT_FILES, 'day_11.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::SeatingSystem.new(input_file).stabilised_occupied_seats
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::SeatingSystem.new(input_file).stabilised_occupied_seats(true)
    end
  end
end
