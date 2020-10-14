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
      while x < self.length
        puts "this are the items insidet the array #{self[x]}"
        x += 1
      end
      yield
    else
      'Block missing'
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

  def my_none?(input = nil) # if all elements are false return true

    return true if !block_given? && self.empty? #This contidion is only when we have an empty input, jus like this "p [].my_none?", so the logic of the roiginal method says, if you have an empty input just return true

    if !block_given? &&  input == Float #This is only going to happen when we don't have a block and when we have an argumnet with the class Float, just like in this "p %w{ant bear cat}.my_none?(/d/)"
        my_each  do |item|
            return false if item.class == input
        end
    elsif !block_given? &&  input.class == Regexp  #This is only going to happen when we don't have a block and when we have an argumnet with the class Float , just like in this "p [1, 3.14, 42].my_none?(Float)"
        my_each  do |item|
            char = item.split('')
            char.my_each do |n|
                p "X" if n.match?(input) 
                return false if n.match?(input) 
            end
        end
        true
    elsif !block_given? && input.nil? #This contidition is only going to happen when we don't have a block and when we don't have an argument, jus like in this "p [nil].my_none?"
        my_each  do |item|
            return false if item == true # if one atleast item is true return false
        end
        true
    elsif block_given? #This condition is only gping to happen when we have a block
        my_each  do |item|
            return false if item == true
            return false if yield(item) 
        end
        true
    end
  end

end



#p [1, 2, 3, 4, 5].my_none?(&proc { |n| (n % 7).zero? }) 
#p [1, 2, 3, 4, 5].my_none?(&proc { |n| n.even? }) 
#p (1..3).my_none?(&proc { |num| num.even? }) 
#p [1, 2, 3, 4, 5].tap { |t| t.my_none? { |n| n % 3 } } 
#p [false, nil, false].my_none? 
#p [false, nil, []].my_none? 
#p [true, []].my_none?(String) 
#p [true, []].my_none?(Numeric) 
#p ['', []].my_none?(String) 
#p %w[dog cat].my_none?(/x/) 
#p %w[dog cat].my_none?(/d/) 
#p %w[dog car].my_none?(5) 
#p [5, 'dog', 'car'].my_none?(5) 

p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false

