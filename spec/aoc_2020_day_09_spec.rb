# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_09' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day09.part_one).to be(31_161_678)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day09.part_two).to be(5_453_868)
      end
    end
  end
end
