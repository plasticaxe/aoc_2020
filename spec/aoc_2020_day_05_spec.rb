# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_05' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day05.part_one).to be(998)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day05.part_two).to be(676)
      end
    end
  end
end
