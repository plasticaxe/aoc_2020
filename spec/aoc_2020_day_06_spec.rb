# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_06' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day06.part_one).to be(6930)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day06.part_two).to be(3585)
      end
    end
  end
end
