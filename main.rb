# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    item_select = []
    my_each { |i| item_select << i if yield(i) }
    item_select
  end

  def my_all?
    return my_each { |i| return false if yield(i) == false } unless block_given?

    true
  end

  def my_any?
    return my_each { |i| return true if yield(i) } unless block_given?

    false
  end

  def my_none?
    return my_each { |i| return false if yield(i) } unless block_given?

    true
  end

  def my_count(items = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif items.nil?
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == items }
    end
    count
  end

  def my_map(arg = nil)
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      arr << if !arg.nil?
               arg.call(i)
             else
               yield(i)
             end
    end
    arr
  end

  def my_inject(value = self[0])
    value ||= []
    my_each do |element|
      value = yield(value, element)
    end
    value
  end
end

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end

var1 = multiply_els([2, 4, 5])
print var1
puts ''

block = proc { |string| string.upcase }
var2 = %w[a b c].my_map(block)
print var2
