# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_04' do
    context 'part_one_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day04.part_one(File.join(Aoc2020::INPUT_FILES, 'day_04_part_1_example.txt'))).to be(2)
      end
    end

    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day04.part_one).to be(222)
      end
    end

    context 'part_two_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day04.part_two(File.join(Aoc2020::INPUT_FILES, 'day_04_part_2_example.txt'))).to be(4)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day04.part_two).to be(140)
      end
    end
  end
end
