# frozen_string_literal: true

require '../main'
RSpec.describe Enumerable do
  let(:arr) { [4, 5, 8, 2, 1, 9, 3, 7, 6] }
  let(:new_arr) { [] }

  describe '#my_each' do
    let(:new_arr_each) { [] }
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(new_arr_each.my_each.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'iterates through array of elements' do
        my_array = []
        original_array = []
        arr.my_each { |i| my_array << i * 2 }
        arr.each { |i| original_array << i * 2 }
        expect(my_array).to eql(original_array)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_each_with_index.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given'
    it 'returns indexes of elements in an array' do
      %w[e nu me ra ble].my_each_with_index { |_elem, index| new_arr << index }
      expect(new_arr).to eql([0, 1, 2, 3, 4])
    end
  end

  describe '#my_count' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_count.is_a?(Enumerable)).to eql(false)
      end
    end

    context 'If block is not given' do
      it 'returns the counts of elements that evaluate to be true' do
        expect(arr.my_count { |i| i < 7 }).to eql(6)
      end
    end
  end

  describe '#my_map' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_map.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'returns a new array with the results of running through the block once on a given array' do
        result = arr.my_map { |i| i**2 }
        expect(result).to eql(arr.map { |i| i**2 })
      end
    end
  end

  describe '#my_none' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_none?.is_a?(Enumerable)).to eql(false)
      end
    end

    context 'If block is given' do
      it 'returns true if none of the element meet the criteria in the block' do
        expect(arr.my_none? { |num| num == 10 }).to eql(true)
      end
    end
  end

  describe '#my_select' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(arr.my_select.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'If block is given' do
      it 'returns selected values in an array based on the given block' do
        expect(arr.my_select(&:odd?)).to eql([5, 1, 9, 3, 7])
      end
    end
  end
end
