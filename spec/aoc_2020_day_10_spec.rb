# frozen_string_literal: true

RSpec.describe Aoc2020 do
  describe 'day_10' do
    context 'part_one_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day10.part_one(File.join(Aoc2020::INPUT_FILES, 'day_10_example.txt'))).to be(220)
      end
    end

    context 'part_two_example' do
      it 'should have the right answer' do
        expect(Aoc2020::Day10.part_two(File.join(Aoc2020::INPUT_FILES, 'day_10_example.txt'))).to be(19_208)
      end
    end

    context 'part_one' do
      it 'should have the right answer' do
        expect(Aoc2020::Day10.part_one).to be(2346)
      end
    end

    # Solution doesn't scale -- need to revisit.
    # context 'part_two' do
    #   it 'should have the right answer' do
    #     expect(Aoc2020::Day10.part_two).to be(-1)
    #   end
    # end
  end
end
