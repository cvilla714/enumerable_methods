# frozen_string_literal: true

# module Enumerable
module Enumerable # rubocop:disable Metrics/ModuleLength
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

  def my_none?
    if !block_given?
      my_each  do |item| 
        if item == nil && item == [] 
          return false
        elsif item == nil
          return true 
        end
        return false unless item == false 
      end
      true
      elsif block_given?
        # return to_enum(:my_none) unless block_given?
        arr = to_a if self.class == Range
        arr = self if self.class == Array
        m = 0
          while m < arr.length
            if yield(arr[m])
              return false
            end
            m += 1
          end
        true
      end
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
end
