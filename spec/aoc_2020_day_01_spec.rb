# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_01' do
    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day01.new.part_one).to be(974_304)
      end
    end

    context 'part_two' do
      it 'should have the right answer' do
        expect(Aoc2020::Day01.new.part_two).to be(236_430_480)
      end
    end
  end
end
