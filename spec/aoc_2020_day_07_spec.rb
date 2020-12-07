# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_07' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day07.part_one).to be(254)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day07.part_two).to be(6006)
      end
    end
  end
end
