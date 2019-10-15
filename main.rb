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

  def my_all?(param = nil)
    my_each { |i| return false if yield(i) === false } if block_given?
    my_each { |_i| return false if item == false } if param.nil?

    true
  end

  def my_any?(param = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif param.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i.class == param }
    end
    false
  end

  def my_none?(param = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif param.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i.class == param }
    end
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

  def my_inject(*args)
    result = self[0]
    self[1..-1].my_each { |i| result = yield(result, i) }
    result
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
