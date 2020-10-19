# frozen_string_literal: true

# rubocop:disable Metrics/BlockNesting,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# module Enumerable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    arr = self if self.class == Hash
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
    arr = self if self.class == Hash
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
    elsif !block_given? && input == String
      my_each do |item|
        return false if item.class == input
      end
      true
    elsif !block_given? && input == Numeric
      my_each do |item|
        return false if item.class == input
      end
      true
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

  def my_count(*args)
    arr = to_a if self.class == Range
    arr = self if self.class == Array

    if !block_given? && args[0].nil?
      counter = 0
      counter += 1 while counter < arr.length
      counter
    elsif !block_given? && !args[0].nil?
      count = 0
      section = 0
      while count < length
        section += 1 if arr[count] == args[0]
        count += 1
      end
      section
    elsif block_given? && args[0].nil?
      num = 0
      ematch = 0
      while num < length
        ematch += 1 if yield(arr[num])
        num += 1
      end
      ematch
    end
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    counter = 0
    tot = []
    while counter < arr.length
      runn = yield(arr[counter])
      tot.push(runn)
      counter += 1
    end
    tot
  end

  def my_inject(args = nil, arg = nil)
    arr = to_a if self.class == Range
    arr = self if self.class == Array
    if !block_given? && !args.nil? && arg.nil? # no blocks and args
      i = 1
      x = 0
      acum = arr[x]
      while i < arr.length
        acum = acum.send(args, arr[i])
        i += 1
      end
      acum
    elsif block_given? && args.nil? && args.nil?
      if arr[0].class == String
        counter = 0
        longest = nil
        while counter < arr.length
          longest = yield(arr[counter], arr[counter + 1]) unless arr[counter + 1].nil?
          counter += 1
        end
        longest
      elsif arr[0].class == Integer
        sum = 1
        num = 0
        total = arr[num]
        while sum < arr.length
          total = yield(total, arr[sum])
          sum += 1
          num += 1
        end
        total
      end
    elsif block_given? && !args.nil? && arg.nil? # blocks and args
      sum = 1
      num = 0
      totals = arr[num]
      while sum < arr.length
        totals = yield(totals, arr[sum])
        sum += 1
        num += 1
      end
      yield(totals, args)
    elsif !block_given? && !args.nil? && !arg.nil? # no blocks and args
      i = 1
      x = 0
      acum = arr[x]
      while i < arr.length
        acum = acum.send(arg, arr[i])
        i += 1
      end
      acum.send(arg, args)
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

      elsif arg == Integer
        my_each { |item| return false if item.class != arg }
        true
      elsif !arg.nil?
        my_each { |item| return false if item != arg }
        true
      end
    elsif !block_given? && arg.nil?
      my_each { |item| return false if item.nil? || item == false }
      true
    elsif !block_given? && empty?
      true
    end
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      false

    elsif !block_given? && !arg.nil?
      if arg.class == Regexp
        my_each  do |item|
          char = item.split('')
          char.my_each do |n|
            return true if n.match?(arg)
          end
        end
        false
      elsif arg.class == String
        my_each  do |item|
          char = item.split(' ')
          char.my_each do |n|
            return true if n.match?(arg)
          end
        end
        false
      elsif arg == Integer
        my_each { |item| return true if item.class == arg }
        false
      elsif arg == Numeric
        my_each { |item| return true if item.class != arg }
        false
      end
    elsif !block_given? && arg.nil?
      my_each { |item| return true if item == true }
      false
    elsif !block_given? && empty?
      true
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array

    array2 = []
    arr.my_each do |item|
      array2.push(item) if yield(item)
    end
    array2
  end
end

# rubocop:enable Metrics/BlockNesting,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# Scenarios for "my_any?" method return true if ANY of the elements is true
#   conditions for my_each
# p [1,2,3].my_each.class              #=======================>Enumerator
# p [1,2,3,4,5].my_each(&proc{|n| n%2})#=======================>[1,2,3,4,5]
# p [1,2,3].my_each(&proc{|x| x>2})    #=======================>[1,2,3]

# conditions for my_each_with_index
# p [1,2,3].my_each_with_index.class  #=====================>Enumerator
# p [1,2,3,4,5].my_each_with_index(&proc{|n| n%2}) #========>[1,2,3,4,5]
# p (1..3).my_each_with_index(&proc{|x| x>2}) #=============>[1,2,3]

# conditions for my_select
# p (1..3).my_select{|x| x>2}
# p [1,2,3,4].my_select
# p (1..10).my_select { |i|  i % 3 == 0 }   #=> [3, 6, 9]
# p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]
# p [:foo, :bar].my_select { |x| x == :foo }   #=> [:foo]

# Scenarios for "my_all?" method return true if ALL of the elements is true
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 3i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# 2nd part of my any
# p [1,2,3].my_all?(&proc{|x| x>x/5})    #=====================>true
# p [1,2,3].my_all?(&proc{|x| x%2==0})   #=====================>false
# p (1..3).my_all?(&proc{|x| x%2==0})    #=====================>false
# p [1,2,3,4,5].tap{|t| t.my_all?{|n| n>3}} #==================>[1,2,3,4,5]
# p [true, [false]].my_all?              #=====================>true
# p [true,[true],false].my_all?          #=====================>false
# p [1,2,3].my_all?(Integer)             #=====================>true
# p [1,-2,3.4].my_all?(Numeric)          #=====================>true
# p ['word',1,2,3].my_all?(Integer)      #=====================>false
# p ['car', 'cat'].my_all?(/a/)          #=====================>true
# p ['car', 'cat'].my_all?(/t/)          #======================>false
# p [5,5,5].my_all?(5)                   #======================>true
# p [5,5,[5]].my_all?(5)                 #=====================>false

# Scenarios for "my_any?" method return true if ANY of the elements is true
# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false

# 2nd part of my_any
# p [1,2,3].my_any?(&proc{|x| x%2==0})                     #=>true
# p [1,2,3].my_any?(&proc{|x| x==0})                       #=>false
# p (1..3).my_any?(&proc{|x| x==0})                        #=>false
# p [1,2,3,4,5].tap{|t| t.any?{|n| n>3}}                   #=>[1,2,3,4,5]
# p [0,[]].my_all?                                         #=>true
# p [false, 0].my_any?                                     #=>false
# p [1.1,'',[]].my_any?(Numeric)                           #=>true
# p [1,'',[]].my_any?(Integer)                             #=>true
# p ['dog', 'cat'].my_any?(/d/)                            #=>true
# p ['dog', 'cat'].my_any?(/z/)                            #=>false
# p ['dog','car'].my_any?('cat')                           #=>false
# p ['cat', 'dog','car'].my_any?('cat')                    #=>true

# Scenarios for "my_none?" method
# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.1, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

# 2nd part of my_none
# p[1,2,3,4,5].my_none?(&proc{|n| n%7==0})
# p[1,2,3,4,5].my_none?(&proc{|n| n%2==0})
# p(1..3).my_none?(&proc{|num| num%2==0})
# p[1,2,3,4,5].tap{|t| t.my_none?{|n| n%3}}
# p [false, nil,false].my_none?                            #=>true
# p [false, false, []].my_none?                            #=>false
# p [true,[]].my_none?(String)                             #=>true
# p [true,[]].my_none?(Numeric)                            #=>true
# p ['',[]].my_none?(String)                               #=>false
# p ['dog','cat'].my_none?(/x/)                            #=>true
# p ['dog', 'cat'].my_none?(/d/)                           #=>false
# p ['dog','car'].my_none?(5)                              #=>true
# p [5,'dog','car'].my_none?(5)                            #=>false

# conditions for count
  # p ary = [3, 3, 3, 2, 4, 2]
  # p ary.my_count #=> 4
  # p names = %w(luigui mario boozer luffy zorro jinbei)
  # p names.my_count
  # p ary.my_count
  # p ary.my_count(3)            #=> 2
  # p ary.my_count{ |x| x%2==0 } #=> 3
# 2nd part of my_count
# p [1,2,3,4,5].my_count                                      #=>5
# p (1..3).my_count                                           #=>3
# p [1,2,3].my_count(1)                                       #=>1
# p [1,2,3].my_count(&proc{|num|num%2==0})                    #=>1
# p [1,2,3,4,5].tap{|t| t.my_count{|n| n%3}}                  #=>[1,2,3,4,5]

# condition for my map
# p (1..4).my_map{ |i| i*i }      #=> [1, 4, 9, 16]
# p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
# p [1,2,3].my_map(&proc{|x|x%2})
# p [1,2,3].map(&proc{|x|x%2})

#   2nd part of my_map
# p [1,2,3].my_map{|x| x==2}                                  #=>[1] just here there is doubt
# p [1,2,3].my_map(&proc{|x|x*2})                             #=>[2,4,6]
# p (1..3).my_map(&proc{|num| num+1})                         #=>[2.3.4]
# p [1,2,3].my_map(&proc{|x|x%2})                             #[1,0,1]

# conditions for my_inject
# Sum some numbers
# p (5..10).my_inject(:+)                             #=> 45
# Same using a block and inject
# p (5..10).my_inject { |sum, n| sum +  n }            #=> 45
# Multiply some numbers
# p (5..10).my_inject(1, :*)                          #=> 151200
# Same using a block
# p (5..10).my_inject(2) { |product, n| product * n } #=> 151200
# find the longest word
# longest = %w{ cat sheep bear biggest}.my_inject do |memo, word|
#  memo.length > word.length ? memo : word
# end
# p longest                                        #=> "sheep"

# 2nd part of my input
# p [1,2,3].my_inject(&proc{|total, num| total*num})          #=>6
# p (1..3).my_inject(&proc{|total, num| total*num})           #=>6
# p (1..3).my_inject(4) { |prod, n| prod * n }                #=>24
# p [1,2,3].my_inject(:+)                                     #=>6
# p (1..9).my_inject(:+)                                      #=>45
# p [1,2,3].my_inject(4, :+)                                  #=>24
# p (1..3).my_inject(4, :*)                                   #=>24
