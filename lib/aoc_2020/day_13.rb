# frozen_string_literal: true

module Aoc2020
  #----
  class ShuttleSearch1
    def initialize(input_file)
      @input       = File.read(input_file).each_line(chomp: true).to_a
      @depart_time = @input[0].to_i
    end

    def id_wait_time
      first_bus = all_times.select { |t| t[:time] >= @depart_time }.min_by { |t| t[:time] }
      first_bus[:id] * (first_bus[:time] - @depart_time)
    end

    def all_times
      raw_times.map { |t| (@depart_time * 2 / t).times.map { |i| { id: t, time: i * t } } }.flatten
    end

    def raw_times
      @input[1].split(',').reject { |t| t.eql?('x') }.map(&:to_i)
    end
  end

  #----
  class ShuttleSearch2
    class Shuttle
      def initialize(id, offset)
        @hash = { id: id.to_i, offset: offset.to_i }
      end

      def id
        @hash[:id]
      end

      def offset
        @hash[:offset]
      end

      def at_index?(index)
        (index + @hash[:offset]) % @hash[:id] == 0
      end
    end

    def initialize(input_file, start_at = 0)
      @shuttle_ids            = File.read(input_file).each_line(chomp: true).to_a[1].split(',').map
      @check_shuttles_ids     = {}
      @check_shuttles_offsets = {}
      @start_at               = start_at
    end

    def shuttles
      @shuttles ||= begin
                      shuttles = []
                      offset   = 0
                      @shuttle_ids.each do |shuttle_id|
                        # shuttles << Shuttle.new(shuttle_id, offset).freeze unless shuttle_id.eql?('x')
                        shuttles << { id: shuttle_id.to_i, offset: offset }.freeze unless shuttle_id.eql?('x')
                        offset += 1
                      end
                      puts "shuttles = #{shuttles}"
                      shuttles
                    end.freeze
    end

    def synced_shuttles
      # first_shuttle_id = shuttles.first.id
      first_shuttle_id = shuttles.first[:id].dup.freeze
      index            = @start_at - (@start_at % first_shuttle_id)
      puts "starting at #{index}"
      loop do
        # index += 15390703
        # index += 200079139
        index += 98639015527
        # Test answer
        # exit if index > 1_068_781
        # puts index if index % 100_000 == 0
        break if check_shuttles(index.dup.freeze)
      end
      index
    end

    def check_shuttles(index)
      shuttles.each_index do |this_index|
        next unless this_index > 0
        prev_index = (this_index - 1).freeze
        # @check_shuttles_ids[this_index] ||= shuttles[this_index].id.freeze
        # @check_shuttles_ids[prev_index] ||= shuttles[prev_index].id.freeze
        # @check_shuttles_offsets[this_index] ||= shuttles[this_index].offset.freeze
        # @check_shuttles_offsets[prev_index] ||= shuttles[prev_index].offset.freeze
        @check_shuttles_ids[this_index] ||= shuttles[this_index][:id].dup.freeze
        @check_shuttles_ids[prev_index] ||= shuttles[prev_index][:id].dup.freeze
        @check_shuttles_offsets[this_index] ||= shuttles[this_index][:offset].dup.freeze
        @check_shuttles_offsets[prev_index] ||= shuttles[prev_index][:offset].dup.freeze
        return false unless arrow_alignment(@check_shuttles_ids[prev_index],
                                            @check_shuttles_ids[this_index],
                                            (index.dup.freeze + @check_shuttles_offsets[prev_index]).freeze,
                                            (@check_shuttles_offsets[this_index] - @check_shuttles_offsets[prev_index]).freeze) == 0
        puts "#{index.dup} :: Alligned shuttles #{prev_index} and #{this_index}" if this_index > 6
      end
      true
    end

    # def synced_shuttles
    #   current        = shuttles[0].id.to_i
    #   current_offset = 0
    #   puts "current = #{current}"
    #   shuttles[1..].each do |shuttle|
    #     puts "shuttle.id.to_i = #{shuttle.id.to_i}"
    #     current        = arrow_alignment(shuttle.id.to_i, current, shuttle.offset.to_i - current_offset)
    #     current_offset = shuttle.offset.to_i
    #     puts "current = #{current}", "current_offset = #{current_offset}"
    #   end
    #   current
    # end
    #

    # https://math.stackexchange.com/questions/2218763/how-to-find-lcm-of-two-numbers-when-one-starts-with-an-offset

    def arrow_alignment(red_len, green_len, index, advantage)
      period, phase = combine_phased_rotations(red_len, index, green_len, -(index + advantage) % green_len)
      # puts "-phase % period = #{-phase % period}"
      (@arrow_alignment ||= {})["#{period}e#{phase}".to_sym] ||= (-phase % period).freeze
    end

    def combine_phased_rotations(a_period, a_phase, b_period, b_phase)
      gcd, s, _t = extended_gcd(a_period, b_period)
      (@combine_phased_rotations ||= {})["#{gcd}e#{s}e#{a_phase}e#{b_phase}".to_sym] ||= begin
        # puts "--- #{gcd}e#{s}e#{a_phase}e#{b_phase}"
        phase_difference      = a_phase - b_phase
        pd_mult, pd_remainder = phase_difference.divmod(gcd)
        raise if pd_remainder > 0
        combined_period = (a_period / gcd * b_period).floor
        combined_phase  = (a_phase - s * pd_mult * a_period) % combined_period
        # puts "combined_period = #{combined_period}, combined_phase = #{combined_phase}"
        [combined_period, combined_phase]
      end.freeze
    end

    def extended_gcd(a, b)
      (@extended_gcd ||= {})["#{a}e#{b}".to_s] ||= begin
       # puts "Getting extended_gcd(#{a}, #{b})"
       old_r, r = a, b
       old_s, s = 1, 0
       old_t, t = 0, 1
       until r.eql?(0)
         quotient, remainder = old_r.divmod(r)
         old_r, r            = r, remainder
         old_s, s            = s, old_s - quotient * s
         old_t, t            = t, old_t - quotient * t
       end
       [old_r, old_s, old_t]
      end.freeze
    end
  end

  #-----
  module Day13
    def self.default_input_file
      # File.join(Aoc2020::INPUT_FILES, 'day_13_example.txt')
      File.join(Aoc2020::INPUT_FILES, 'day_13.txt')
    end

    def self.part_one(input_file = default_input_file)
      Aoc2020::ShuttleSearch1.new(input_file).id_wait_time
    end

    def self.part_two(input_file = default_input_file)
      # Aoc2020::ShuttleSearch2.new(input_file, 10_000).synced_shuttles
      # Aoc2020::ShuttleSearch2.new(input_file, 100_000_000_000_000).synced_shuttles
      Aoc2020::ShuttleSearch2.new(input_file, 147061671838595).synced_shuttles
      # Aoc2020::ShuttleSearch2.new(input_file, 100_000_000_000_000).test
    end
  end
end
