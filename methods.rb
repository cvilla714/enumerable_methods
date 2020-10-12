# frozen_string_literal: true

# module Enumerable
module Enumerable
  def my_each
    arr = Array(this)
    if block_given?
      n = 0
      while n < arr.length
        yield(arr[n])
        n += 1
      end
    else
      p 'Block missing'
    end
  end

  def my_each_with_index(arr)
    if block_given?
      n = 0
      while n < arr.length
        yield(arr[n], n)
        n += 1
      end
    else
      p 'Block missing'
    end
  end

  def my_select(arr)
    if block_given?
      array2 = []
      my_each(arr) do |item|
        array2.push(item) if yield(item)
      end
      array2
    else
      p 'Block missing'
    end
  end

  def my_all(arr)
    if block_given?
      my_each(arr) do |item|
        return false unless yield(item)
      end
      true
    else
      p 'Block missing'
    end
  end

  def my_any(arr)
    if block_given?
      my_each(arr) do |item|
        return true if yield(item)
      end
      false
    else
      p 'Block missing'
    end
  end

  def my_none(arr)
    m = 0
    while m < arr.length
      puts "The city name is #{arr[m]}, The length's name is #{arr[m].length}" if yield(arr[m])
      m += 1
    end
  end

  def my_count(numbers)
    x = 0
    while x < numbers.length
      puts "this are the items insidet the array #{numbers[x]}"
      x += 1
    end
    yield
  end

  def my_map(num)
    t = 0
    while t < num.length
      yield(num[t])
      t += 1
    end
  end

  def my_inject(totals)
    e = 0
    maint = 0
    while e < totals.length
      puts totals[e]
      maint += yield[e]
      e += 1
    end
    puts maint
  end

  def multiply_els(numarr)
    e = 0
    maint = 1
    while e < numarr.length
      puts numarr[e]
      maint *= yield[e]
      e += 1
    end
    puts maint
  end

  def my_map_proc(numofarr)
    m = 0
    m += 1 while m < numofarr.length
    yield()
  end
end
