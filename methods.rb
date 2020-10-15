# frozen_string_literal: true

# rubocop:disable Layout/LineLength,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# module Enumerable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    n = 0
    while n < arr.length
      yield(arr[n])
      n += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    n = 0
    while n < arr.length
      yield(arr[n], n)
      n += 1
    end
    self
  end

  def my_none?(input = nil)
    return true if !block_given? && empty?

    if !block_given? && input == Float
      my_each do |item|
        return false if item.class == input
      end
    elsif !block_given? && input.class == Regexp
      my_each  do |item|
        char = item.split('')
        char.my_each do |n|
          return false if n.match?(input)
        end
      end
      true
    elsif !block_given? && input.nil?
      my_each do |item|
        return false if item == true
      end
      true
    elsif block_given?
      my_each do |item|
        return false if item == true
        return false if yield(item)
      end
      true
    end
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |item| return false unless yield(item) }
      true

    elsif !block_given? && !arg.nil?
      if arg.class == Regexp
        my_each { |item| return false unless item.match?(arg) }
        true

      elsif arg == Numeric
        my_each { |item| return false if item.class.superclass != arg }
        true
      end
    elsif !block_given? && arg.nil?
      my_each { |item| return false if item.nil? }
      true
    elsif !block_given? && empty?
      true
    end
  end
end
# rubocop:enable Layout/LineLength,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# Scenarios for "my_all?" method

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 3i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# Scenarios for "my_none" method

# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false
