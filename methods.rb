# frozen_string_literal: true

# applyig the loops to the methods i need

# arrays of strings
cities = %w[montreal manhattan jersey atlanta hollywood]
# array or numbers
totals = [-10, 20, 30, 40, 50, 8, 100]
tot_inject = [1, 3, 5, 7, 9]
injectotal = 0
my_array = [5, 9, 3, 2, 4, 1]

def my_each(arr)
  n = 0
  while n < arr.length
    yield(arr[n])
    n += 1
  end
end

my_each(my_array) { |index| print index * 2 }

def my_each_with_index(arr)
  n = 0
  while n < arr.length
    yield(arr[n], n)
    n += 1
  end
end

my_each_with_index(my_array) do |item, index|
  p item if index == 2
end

def my_select(arr)
  array2 = []
  my_each(arr) do |item|
    array2.push(item) if yield(item)
  end
  array2
end

p my_select(my_array, &:positive?)

def my_all(arr)
  my_each(arr) do |item|
    return false unless yield(item)
  end
  true
end

p my_all(my_array, &:positive?)

def my_any(arr)
  my_each(arr) do |item|
    return true if yield(item)
  end
  false
end

p my_any(my_array, &:negative?)

def my_none(arr)
  m = 0
  while m < arr.length
    if yield(arr[m])
      puts "The city name is #{arr[m]}, The length's name is #{arr[m].length}"
    end
    m += 1
  end
end

my_none(cities) { |index| index.length > 5 }

def my_count(numbers)
  x = 0
  while x < numbers.length
    puts "this are the items insidet the array #{numbers[x]}"
    x += 1
  end
  yield
end

my_count(totals) { puts "the number of items is #{totals.length}" }

def my_map(num)
  t = 0
  while t < num.length
    yield(num[t])
    t += 1
  end
end

my_map(totals) { |num| puts num * 3 }

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

my_inject(tot_inject) { [1, 3, 5, 7, 9] }
tot_inject.each { |n| injectotal += n }
puts injectotal

def mytiply_els(numarr)
  e = 0
  maint = 1
  while e < numarr.length
    puts numarr[e]
    maint *= yield[e]
    e += 1
  end
  puts maint
end

mytiply_els(tot_inject) { [1, 3, 5, 7, 9] }
