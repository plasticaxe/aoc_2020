# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_12' do
    context 'part_one_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day12.part_one(File.join(Aoc2020::INPUT_FILES, 'day_12_example.txt'))).to be(25)
      end
    end

    context 'part_two_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day12.part_two(File.join(Aoc2020::INPUT_FILES, 'day_12_example.txt'))).to be(286)
      end
    end

    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day12.part_one).to be(879)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day12.part_two).to be(18107)
      end
    end
  end
end
