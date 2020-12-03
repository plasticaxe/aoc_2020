# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_02' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day02.part_one).to be(456)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day02.part_two).to be(308)
      end
    end
  end
end
