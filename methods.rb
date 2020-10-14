# frozen_string_literal: true

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

  def my_select
    if block_given?
      array2 = []
      my_each do |item|
        array2.push(item) if yield(item)
      end
      array2
    else
      'Block missing'
    end
  end

  def my_all
    if block_given?
      my_each do |item|
        return false unless yield(item)
      end
      true
    else
      'Block missing'
    end
  end

  def my_any
    if block_given?
      my_each  do |item|
        return true if yield(item)
      end
      false
    else
      'Block missing'
    end
  end

  def my_count
    if block_given?
      x = 0
      while x < length
        puts "this are the items insidet the array #{self[x]}"
        x += 1
      end
      yield
    else
      'Block missing'
    end
    yield
    # else
    # 'Block missing'
  end
end

def my_map
  if block_given?
    t = 0
    while t < length
      yield(self[t])
      t += 1
    end
  else
    'Block missing'
  end
end

def my_inject
  if block_given?
    e = 0
    maint = 0
    while e < length
      puts self[e]
      maint += yield[e]
      e += 1
    end
    puts maint
  else
    'Block missing'
  end
end

def multiply_els
  if block_given?
    e = 0
    maint = 1
    while e < length
      puts self[e]
      maint *= yield[e]
      e += 1
    end
    puts maint
  else
    'Block missing'
  end
end

def my_map_proc
  if block_given?
    m = 0
    m += 1 while m < length
    yield
  else
    'Block missing'
  end
end

def my_nonetwo?
  # arr = to_a if self.class == Range
  # arr = self if self.class == Array
  # arg = arr

  # if !block_given?
  # my_each do |item|
  # if item.nil? && item == []
  # return false
  # elsif item == []
  # return true
  # elsif item.nil?
  # return true
  # end
  # return false unless item == false
  # end

  unless block_given?
    my_each do |element|
      p element * 2
      # return false
    end
    # true
  end
  # end
  # elsif block_given?
  # return to_enum(:my_none) unless block_given?
  # arr = to_a if self.class == Range
  # arr = self if self.class == Array
  # m = 0
  # while m < arr.length
  # return false if yield(arr[m])
  # m += 1
  # end
  # true
  # end
# end

def my_none?(*input) # if all elements are false return true
  return true if !block_given? && empty?

  if !block_given?
    my_each do |item|
      return false if item.class == input[0]
    end
  elsif !block_given?
    my_each do |item|
      char = item.split('')
      char.my_each do |n|
        return false if n.match?(input[0])
      end
    end
    true
  elsif !block_given?
    my_each do |item|
      return false if item == true # if one atleast item is true return false
    end
    true
  elsif block_given?
      #        arr = to_a if self.class == Range
      #        arr = self if self.class == Array
      my_each do |item|
        return false if item == true
        return false if yield(item)
      end
      true
      end
  end
end

# p [1, 2, 3, 4, 5].my_none?(&proc { |n| (n % 7).zero? })
# p [1, 2, 3, 4, 5].my_none?(&proc { |n| n.even? })
# p (1..3).my_none?(&proc { |num| num.even? })
# p [1, 2, 3, 4, 5].tap { |t| t.my_none? { |n| n % 3 } }
# p [false, nil, false].my_none?
# p [false, nil, []].my_none?
# p [true, []].my_none?(String)
# p [true, []].my_none?(Numeric)
# p ['', []].my_none?(String)
# p %w[dog cat].my_none?(/x/)
# p %w[dog cat].my_none?(/d/)
# p %w[dog car].my_none?(5)
# p [5, 'dog', 'car'].my_none?(5)

# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_none?(/d/) #=> true
# p [1, 3.14, 42].my_none?(Float) #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false
