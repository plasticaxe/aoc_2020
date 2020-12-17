# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_11' do
    context 'part_one_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day11.part_one(File.join(Aoc2020::INPUT_FILES, 'day_11_example.txt'))).to be(37)
      end
    end

    context 'part_two_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day11.part_two(File.join(Aoc2020::INPUT_FILES, 'day_11_example.txt'))).to be(26)
      end
    end

    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day11.part_one).to be(2299)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day11.part_two).to be(2047)
      end
    end
  end
end
