# frozen_string_literal: true

require 'aoc_2020/version'
require 'aoc_2020/cli'
require 'aoc_2020/day_01'
require 'aoc_2020/day_02'
require 'aoc_2020/day_03'
require 'aoc_2020/day_04'
require 'aoc_2020/day_05'
require 'aoc_2020/day_06'
require 'aoc_2020/day_07'
require 'aoc_2020/day_08'

module Aoc2020
  INPUT_FILES = File.join(__dir__, '..', 'resources', 'input')

  class Error < StandardError; end
end
