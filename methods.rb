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
    if !block_given? &&  args[0] == nil 
    counter = 0
    while counter < self.length
      counter +=1
    end
     counter
  elsif !block_given? &&  args[0] != nil
    count = 0
    section = 0
    while count < self.length
      if self[count] == args[0]
        section += 1
        end
      count += 1
    end
      section
   elsif block_given? && args[0] == nil
      num = 0
      ematch= 0
      while num < self.length
        if yield(self[num])
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


  def my_inject(args=nil)
    arr = to_a if self.class == Range
    arr = self if self.class == Array
    if !block_given? && !args.nil? # no blocks and args
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
  elsif block_given? && args.nil?
      counter = 0 
      longest = nil
      # word = 0
      while counter < arr.length
        # puts arr[counter]
        if !arr[counter+1].nil?
        # print "yooo"
        longest = yield(arr[counter],arr[counter+1])
        # runn = yield(arr[counter],arr[counter+1])
        # yield(arr[counter],arr[counter+1])
          # p runn
          # word += 1
        #  longest.push(runn)
        end
        counter+=1
        # longest.push(runn)
      end
      # counter        
      puts "hello"
      # puts longest.to_s
      return longest
    end
  end
# end       

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
end



# rubocop:enable Layout/LineLength,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# Scenarios for "my_any?" method return true if ANY of the elements is true

# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false

# Scenarios for "my_all?" method return true if ALL of the elements is true

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 3i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# Scenarios for "my_none?" method

# p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

# conditions for count
# p ary = [3, 3, 3, 2, 4, 2]
# p ary.my_count #=> 4
# p names = %w(luigui mario boozer luffy zorro jinbei)
# p names.my_count
# p ary.my_count
# p ary.my_count(3)            #=> 2
# p ary.my_count{ |x| x%2==0 } #=> 3

# condition for my map
# p (1..4).my_map{ |i| i*i }      #=> [1, 4, 9, 16]
# p (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]


# conditions for my_inject
# Sum some numbers
p (5..10).my_inject(:*)                             #=> 45
# Same using a block and inject
# (5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
# (5..10).reduce(1, :*)                          #=> 151200
# Same using a block
# (5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear biggest looooping}.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"

# longest = %w{ cat sheep bear biggest }.inject do |memo, word|
  # memo.length > word.length ? memo : word
# end
# p longest                                        #=> "sheep"