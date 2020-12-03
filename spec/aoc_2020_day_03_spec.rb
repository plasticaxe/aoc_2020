# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_03' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day03.part_one).to be(230)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day03.part_two).to be(9_533_698_720)
      end
    end
  end
end
