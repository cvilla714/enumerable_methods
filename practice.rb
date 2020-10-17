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
  
    def my_count(*args)
        arr = to_a if self.class == Range
        arr = self if self.class == Array
      
        if !block_given? &&  args[0] == nil 
      counter = 0
      while counter < arr.length
        counter +=1
      end
       counter
    elsif !block_given? &&  args[0] != nil
      count = 0
      section = 0
      while count < arr.length
        if arr[count] == args[0]
          section += 1
          end
        count += 1
      end
        section
     elsif block_given? && args[0] == nil
        num = 0
        ematch= 0
        while num < arr.length
          if yield(arr[num])
            ematch += 1
        end
        num+=1
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
         while counter <arr.length
          runn =  yield(arr[counter])
             tot.push(runn)
            counter += 1
         end
        tot
    end
  
  
    def my_inject(args=nil,arg=nil)
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
          #elsif block_given? && args.empty? # block and no args
          #  "block / no args"
            #
          #elsif block_given? && !args.empty? # blocks and args
          #  "block / args"
          # end
        elsif block_given? && args.nil? && args.nil?
        if arr[0].class == String
            counter = 0 
            longest = nil
            result = 0
              while counter < arr.length
                if !arr[counter+1].nil?
                longest = yield(arr[counter],arr[counter+1])    
              end
              counter+=1
              end
            return longest
          elsif arr[0].class == Integer
            sum = 1
            num = 0
            total = arr[num]
            while sum < arr.length
              # puts arr[sum]
              total = yield(total,arr[sum])
              sum+=1
              num+=1
            end
             # return total
            return total
             end
            elsif block_given? && !args.nil? && arg.nil? # blocks and args
              sum = 1
              num = 0
              total = arr[num]
              while sum < arr.length
                total = yield(total,arr[sum])
                sum+=1
                num+=1
              end
             total = yield(total, args)
            # end
            elsif !block_given? && !args.nil? && !arg.nil? # no blocks and args
                i = 1
                x = 0
                acum = arr[x]
                while i < arr.length
                  acum = acum.send(arg, arr[i])
                  i += 1
                end
                acum = acum.send(arg,args)
         end
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
        elsif arg == Integer
          my_each { |item| return true if item.class == arg }
          false
        end
      elsif !block_given? && arg.nil?
        my_each { |item| return true if item == true }
        false
      elsif !block_given? && empty?
        true
      end
    end
  
  
  
  
  # rubocop:enable Layout/LineLength,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize
  
#   conditions for my_each
#p [1,2,3].my_each.class
#p [1,2,3,4,5].my_each(&proc{|n| n%2})
#p [1,2,3].my_each(&proc{|x| x>2})


#conditions for my_each_with_index
#p [1,2,3].my_each_with_index.class
#p [1,2,3,4,5].my_each_with_index(&proc{|n| n%2})
#p (1..3).my_each_with_index(&proc{|x| x>2})


# conditions for my_select
#p (1..3).my_select(&proc{|x| x>2})
#p [1,2,3,4].my_select.class


# Scenarios for "my_all?" method return true if ALL of the elements is true
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 3i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# 2nd part of my any
# p [1,2,3].my_all?(&proc{|x| x>x/5})
# p [1,2,3].my_all?(&proc{|x| x%2==0})
# p (1..3).my_all?(&proc{|x| x%2==0})
# p [1,2,3,4,5].tap{|t| t.my_all?{|n| n>3}}
# p [true, [false]].my_all?
# p [true,[true],false].my_all?
# p [1,2,3].my_all?(Integer)
# p [1,-2,3.4].my_all?(Numeric)
# p ['word',1,2,3].my_all?(Integer)
# p ['car', 'cat'].my_all?(/a/)
# p ['car', 'cat'].my_all?(/t/)
# p 5,5,5].my_all?(5)
# p [5,5,5].my_all?(5)
# p [5,5,[5]].my_all?(5)


# Scenarios for "my_any?" method return true if ANY of the elements is true
# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false

# 2nd part of my_any
#p [1,2,3].my_any?(&proc{|x| x%2==0})
#p [1,2,3].my_any?(&proc{|x| x==0})
#p (1..3).my_any?(&proc{|x| x==0})
#p [1,2,3,4,5].tap{|t| t.any?{|n| n>3}}
#p [false, 0].my_any?
#p [1.1,'',[]].my_any?(Numeric)
#p [1,'',[]].my_any?(Integer)
#p ['dog', 'cat'].my_any?(/d/)
#p ['dog', 'cat'].my_any?(/z/)
#p ['dog','car'].my_any?('cat')
#p ['cat', 'dog','car'].my_any?('cat')
                
# Scenarios for "my_none?" method
#p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
#p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
#p %w{ant bear cat}.my_none?(/d/)                        #=> true
#p [1, 3.14, 42].my_none?(Float)                         #=> false
#p [].my_none?                                           #=> true
#p [nil].my_none?                                        #=> true
#p [nil, false].my_none?                                 #=> true
#p [nil, false, true].my_none?                           #=> false

# 2nd part of my_none
#p[1,2,3,4,5].my_none?(&proc{|n| n%7==0})
#p[1,2,3,4,5].my_none?(&proc{|n| n%2==0})
#p(1..3).my_none?(&proc{|num| num%2==0})
#p[1,2,3,4,5].tap{|t| t.my_none?{|n| n%3}}
#p[false, nil,false].my_none?
#p[false, nil,[]].my_none?
#p[true,[]].my_none?(String)
#p[true,[]].my_none?(Numeric)
#p['',[]].my_none?(String)
#p['dog','cat'].my_none?(/x/)
#p['dog', 'cat'].my_none?(/d/)
#p['dog','car'].my_none?(5)
#p[5,'dog','car'].my_none?(5)


  # conditions for count
#   p ary = [3, 3, 3, 2, 4, 2]
#   p ary.my_count #=> 4
#   p names = %w(luigui mario boozer luffy zorro jinbei)
#   p names.my_count
#   p ary.my_count
#   p ary.my_count(3)            #=> 2
#   p ary.my_count{ |x| x%2==0 } #=> 3
# 2nd part of my_count
  p [1,2,3,4,5].my_count
  p (1..3).my_count
  p [1,2,3].my_count(1)
  p [1,2,3].my_count(&proc{|num|num%2==0})
  p [1,2,3,4,5].tap{|t| t.my_count{|n| n%3}}

  
  # condition for my map
  # p (1..4).my_map{ |i| i*i }      #=> [1, 4, 9, 16]
  # p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
  # p [1,2,3].my_map(&proc{|x|x%2})
  # p [1,2,3].map(&proc{|x|x%2})
#   2nd part of my_map
  #p[1,2,3].my_map{|x| x==2}
  #p[1,2,3].my_map(&proc{|x|x*2})
  #p(1..3).my_map(&proc{|num| num+1})
  #p[1,2,3].my_map(&proc{|x|x%2})
  
  # conditions for my_inject
  # Sum some numbers
  # p (5..10).my_inject(:*)                             #=> 45
  # Same using a block and inject
  # p (5..10).my_inject { |sum, n| sum *  n }            #=> 45
  # Multiply some numbers
  # p (5..10).my_inject(1, :+)                          #=> 151200
  # Same using a block
  # p (5..10).my_inject(2) { |product, n| product * n } #=> 151200
  # find the longest word
  # longest = %w{ cat sheep bear biggest}.my_inject do |memo, word|
    #  memo.length > word.length ? memo : word
  # end
  # p longest                                        #=> "sheep"