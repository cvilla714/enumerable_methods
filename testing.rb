# frozen_string_literal: true

# rubocop:disable Metrics/BlockNesting,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize

# module Enumerable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a if self.class == Range
    arr = self if self.class == Array
    arr = to_a if self.class == Hash
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
    arr = to_a if self.class == Hash
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
    elsif !block_given? && !input.nil?
      my_each do |item|
        return false if item.to_s == input.to_s
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

  def my_map(proc = nil)
    
    arr = to_a if self.class == Range
    arr = self if self.class == Array
    tot = []

    if !block_given? && proc.nil? # no block / no args
      return to_enum(:my_map)

    elsif !block_given? && !proc.nil? # no block / args
      my_each { |x| tot.push(proc[x]) }
      tot

    elsif block_given? && !proc.nil? # blocks / args
      my_each { |x| tot.push(proc[x]) }
      tot

    elsif block_given? && proc.nil? # block / no args
      counter = 0
      while counter < arr.length
        runn = yield(arr[counter])
        tot.push(runn)
        counter += 1
      end
      tot
    end
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
    elsif !block_given? && args.nil? && args.nil? # no blocck and no args
      yield
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

  def multiply_els(args2 = nil, arg2 = nil)
    arr = to_a if self.class == Range
    arr = self if self.class == Array
   if block_given? && args2.nil? && arg2.nil?
    my_inject{|total,num| yield(total,num)}
    elsif block_given? && !args2.nil? && arg2.nil? # blocks one argument
      my_inject(args2){|total,num| yield(total,num) }
    elsif !block_given? && !args2.nil? && arg2.nil? # no blocks and one  args
      my_inject(args2)
    elsif !block_given? && !args2.nil? && !arg2.nil? # no blocks two args
      my_inject(args2,arg2)
    elsif !block_given? && args2.nil? && arg2.nil? # no blocks and args
      return to_enum(:multiply_els)
    end
  end

end

# rubocop:enable Metrics/BlockNesting,Metrics/MethodLength,Metrics/ModuleLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize
