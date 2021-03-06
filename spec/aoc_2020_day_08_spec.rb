# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_08' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day08.part_one).to be(2034)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day08.part_two).to be(672)
      end
    end
  end
end
