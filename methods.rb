# frozen_string_literal: true

# module Enumerable
module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    if block_given?
      n = 0
      while n < length
        yield(self[n])
        n += 1
      end
    else
      'Block missing'
    end
  end

  def my_each_with_index
    if block_given?
      n = 0
      while n < length
        yield(self[n], n)
        n += 1
      end
    else
      'Block missing'
    end
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

  def my_none
    if block_given?
      m = 0
      while m < length
        p "The city name is #{self[m]}, The length's name is #{self[m].length}" if yield(self[m])
        m += 1
      end
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
      maint
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
      maint
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
