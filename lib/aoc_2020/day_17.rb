# frozen_string_literal: true

module Aoc2020
  #----
  class Day17Part1
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
      @grid  = {}
      initial_setup
    end

    def run
      1.upto(6).each do |_n|
        run_cycle
      end
      @grid.values.count { |v| v.eql?('#') }
    end

    def initial_setup
      @input.each_with_index do |row, y|
        row.chars.each_with_index { |value, x| @grid[[x, y, 0]] = value }
      end
    end

    def run_cycle
      seed_all_neighbours
      grid_updates = {}
      @grid.dup.each_pair do |xyz, v|
        active_neighbours = get_active_neighbours(xyz)
        if v.eql?('#') && !(active_neighbours.eql?(2) || active_neighbours.eql?(3))
          grid_updates[xyz] = '.'
        elsif v.eql?('.') && active_neighbours.eql?(3)
          grid_updates[xyz] = '#'
        end
      end
      @grid.merge!(grid_updates)
    end

    def get_active_neighbours(xyz)
      all_neighbours(xyz).count { |n_xyz| @grid[n_xyz].to_s.eql?('#') }
    end

    def all_neighbours(xyz)
      (@all_neighbours ||= {})[xyz] ||= begin
        cube_x, cube_y, cube_z = xyz
        neighbours = []
        (cube_x - 1).upto(cube_x + 1).each do |x|
          (cube_y - 1).upto(cube_y + 1).each do |y|
            (cube_z - 1).upto(cube_z + 1).each do |z|
              neighbours << [x, y, z] unless x.eql?(xyz[0]) && y.eql?(xyz[1]) && z.eql?(xyz[2])
            end
          end
        end
        neighbours
      end
    end

    def seed_all_neighbours
      @grid.dup.each_key do |xyz|
        all_neighbours(xyz).each do |n_xyz|
          x, y, z = n_xyz
          @grid[[x, y, z]] ||= '.'
        end
      end
    end
  end

  #----
  class Day17Part2
    def initialize(input_file)
      @input = File.read(input_file).each_line(chomp: true).to_a
      @grid  = {}
      initial_setup
    end

    def run
      1.upto(6).each do |_n|
        run_cycle
      end
      @grid.values.count { |v| v.eql?('#') }
    end

    def initial_setup
      @input.each_with_index do |row, y|
        row.chars.each_with_index { |value, x| @grid[[x, y, 0, 0]] = value }
      end
    end

    def run_cycle
      seed_all_neighbours
      grid_updates = {}
      @grid.dup.each_pair do |xyzw, v|
        active_neighbours = get_active_neighbours(xyzw)
        if v.eql?('#') && !(active_neighbours.eql?(2) || active_neighbours.eql?(3))
          grid_updates[xyzw] = '.'
        elsif v.eql?('.') && active_neighbours.eql?(3)
          grid_updates[xyzw] = '#'
        end
      end
      @grid.merge!(grid_updates)
    end

    def get_active_neighbours(xyzw)
      all_neighbours(xyzw).count { |n_xyzw| @grid[n_xyzw].to_s.eql?('#') }
    end

    def all_neighbours(xyzw)
      (@all_neighbours ||= {})[xyzw] ||= begin
        cube_x, cube_y, cube_z, cube_w = xyzw
        neighbours = []
        (cube_x - 1).upto(cube_x + 1).each do |x|
          (cube_y - 1).upto(cube_y + 1).each do |y|
            (cube_z - 1).upto(cube_z + 1).each do |z|
              (cube_w - 1).upto(cube_w + 1).each do |w|
                unless x.eql?(xyzw[0]) && y.eql?(xyzw[1]) && z.eql?(xyzw[2]) && w.eql?(xyzw[3])
                  neighbours << [x, y, z, w]
                end
              end
            end
          end
        end
        neighbours
      end
    end

    def seed_all_neighbours
      @grid.dup.each_key do |xyzw|
        all_neighbours(xyzw).each do |n_xyzw|
          x, y, z, w = n_xyzw
          @grid[[x, y, z, w]] ||= '.'
        end
      end
    end
  end

  #-----
  module Day17
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_17_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_17.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::Day17Part1.new(input_file).run
    end

    def self.part_two(input_file = default_input_file)
      Aoc2020::Day17Part2.new(input_file).run
    end
  end
end
