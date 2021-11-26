# frozen_string_literal: true

module Aoc2020
  #----
  class SeatingSystem
    def initialize(input_file)
      @seats = File.read(input_file).each_line(chomp: true).map(&:chars)
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
              elsif adjacent_seats_empty?(row, col)
                modified_seats[row][col] = '#'
              end
            when '#'
              if including_visible
                modified_seats[row][col] = 'L' if visible_seats_occupied?(row, col)
              elsif adjacent_seats_occupied?(row, col)
                modified_seats[row][col] = 'L'
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
      array = [seats_north(row, col), seats_south(row, col), seats_east(row, col), seats_west(row, col)]
      seats_north_east(array, row, col)
      seats_south_east(array, row, col)
      seats_south_west(array, row, col)
      seats_north_west(array, row, col)
      array
    end

    def seats_north(row, col)
      (row - 1).downto(0).map { |r| @seats[r][col] }.reject { |x| x.eql?('.') }.first
    end

    def seats_east(row, col)
      (col + 1).upto(@seats[row].length - 1).map { |c| @seats[row][c] }.reject { |x| x.eql?('.') }.first
    end

    def seats_south(row, col)
      (row + 1).upto(@seats.size - 1).map { |r| @seats[r][col] }.reject { |x| x.eql?('.') }.first
    end

    def seats_west(row, col)
      (col - 1).downto(0).map { |c| @seats[row][c] }.reject { |x| x.eql?('.') }.first
    end

    def seats_north_east(array, row, col)
      loop do
        row -= 1
        col += 1
        break if illegal_seat?(row, col)
        next unless ['#', 'L'].include?(@seats[row][col])

        array << @seats[row][col]
        break
      end
    end

    def seats_south_east(array, row, col)
      loop do
        row += 1
        col += 1
        break if illegal_seat?(row, col)
        next unless ['#', 'L'].include?(@seats[row][col])

        array << @seats[row][col]
        break
      end
    end

    def seats_south_west(array, row, col)
      loop do
        row += 1
        col -= 1
        break if illegal_seat?(row, col)
        next unless ['#', 'L'].include?(@seats[row][col])

        array << @seats[row][col]
        break
      end
    end

    def seats_north_west(array, row, col)
      loop do
        row -= 1
        col -= 1
        break if illegal_seat?(row, col)
        next unless ['#', 'L'].include?(@seats[row][col])

        array << @seats[row][col]
        break
      end
    end

    def illegal_seat?(row, col)
      row.negative? || col.negative? || @seats[row].nil? || @seats[row][col].nil?
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
