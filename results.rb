require_relative './testing.rb'

# Scenarios for "my_any?" method return true if ANY of the elements is true
#   conditions for my_each
# p [1,2,3].my_each.class              #=======================>Enumerator
# p [1,2,3].each.class              #=======================>Enumerator
# p [1, 2, 3, 4, 5].my_each(&proc { |n| p n.even? }) #=======================>[1,2,3,4,5]
# p [1, 2, 3, 4, 5].each(&proc { |n| p n.even? }) #=======================>[1,2,3,4,5]
# p [1, 2, 3].my_each(&proc { |x| p x > 2 }) #=======================>[1,2,3]
# p [1, 2, 3].my_each { |x| p x > 2 } #=======
# enum = { a: 1, b: 2, c: 3, d: 4, e: 5 }
# my_each_output = ''
# block = proc { |num| my_each_output += num.to_s }
# enum.each(&block)
# each_output = my_each_output.dup
# my_each_output = ''
# enum.my_each_with_index(&block)
# These two variables should be the same.
# p my_each_output
# p each_output

# conditions for my_each_with_index
# p [1, 2, 3].my_each_with_index.class #=====================>Enumerator
# p [1, 2, 3].each_with_index.class #=====================>Enumerator
# p [1, 2, 3, 4, 5].my_each_with_index(&proc { |n| p n % 2 }) #========>[1,2,3,4,5]
# p [1, 2, 3, 4, 5].each_with_index(&proc { |n| p n % 2 }) #========>[1,2,3,4,5]
# p (1..3).my_each_with_index(&proc { |x| p x > 2 }) #=============>[1,2,3]
# p (1..3).each_with_index(&proc { |x| p x > 2 }) #=============>[1,2,3]

# conditions for my_select
<<<<<<< HEAD
p (1..3).my_select{|x| x>2}
p (1..3).select{|x| x>2}
# p [1, 2, 3, 4].my_select
# p [1, 2, 3, 4].select
=======
# p (1..3).my_select{|x| x>2}
#p [1,2,3,4].my_select
#p [1,2,3,4].select
>>>>>>> 3d43b191941a8cd49da4963c8082065a99aa7142
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
# p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
# p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# p %w{ant bear cat}.my_none?(/d/)                        #=> true
# p [1, 3.1, 42].my_none?(Float) #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none? #=> false

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
# p [5, 'dog', 'car'].my_none?(5)                            #=>false
# words = %w[dog door rod blade]
# p words.my_none?(5)                                         #true
# words2 = %w[5 dog door rod blade]
# p words2.my_none?(5)                                         #false

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
# p [1, 2, 3].my_count(1) #=>1
# p [1, 2, 3].my_count(&proc { |num| num.even? }) #=>1
# p [1,2,3,4,5].tap{|t| t.my_count{|n| n%3}}                  #=>[1,2,3,4,5]

# condition for my map
# p (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
# p (1..4).my_map { 'cat' } #=> ["cat", "cat", "cat", "cat"]
# p [1,2,3].my_map(&proc{|x|x%2})
# numbers = proc { |n| n * 2 }
# p [2, 3, 4, 5].my_map
# p [2, 3, 4, 5].my_map(numbers)
# p [2, 3, 4, 5].my_map(numbers) { |x| x + 2 }

# (Proc=b, {}=x)

#   2nd part of my_map
# p [1,2,3].my_map{|x| x==2}                                  #=>[1] just here there is doubt
# p [1,2,3].my_map(&proc{|x|x*2})                             #=>[2,4,6]
# p (1..3).my_map(&proc{|num| num+1})                         #=>[2.3.4]
# p [1,2,3].my_map(&proc{|x|x%2})                             #[1,0,1]

# conditions for my_inject
# Sum some numbers
# p (5..10).my_inject(:+)                             #=> 45
# Same using a block and inject
# p (5..10).my_inject { |sum, n| sum + n } #=> 45
# Multiply some numbers
# p (5..10).my_inject(1, :*)                          #=> 151200
# Same using a block
# p (5..10).my_inject(2) { |product, n| product * n } #=> 151200
# find the longest word
# longest = %w[cat sheep bear biggest].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest #=> "sheep"

# 2nd part of my input
# p [1, 2, 3].my_inject(&proc { |total, num| total * num }) #=>6
# p (1..3).my_inject(&proc { |total, num| total * num }) #=>6
# p [1, 2, 3].my_inject { |total, num| total * num } #=>6
# p (1..3).my_inject { |total, num| total * num } #=>6
# p (1..3).my_inject(4) { |prod, n| prod * n } #=>24
# p [1, 2, 3].my_inject(:+) #=>6
# p (1..9).my_inject(:+) #=>45
# p [1, 2, 3].my_inject(4, :+) #=>24
# p (1..3).my_inject(4, :*) #=>24
# p (1..3).my_inject #=>return the enumerator

# multiply_els
# p [1, 2, 3,4,5].multiply_els{ |total, num| total * num } #=>120
# p [1, 2, 3,4,5].multiply_els(&proc { |total, num| total * num }) #=>120
# p (1..5).multiply_els(&proc { |total, num| total * num }) #=>120
# p [2,2,3,2].multiply_els{ |total,num| total * num} #=>24
# p(1..3).multiply_els(4) { |prod, n| prod * n } #=>24
# p [1, 2, 3].multiply_els(:*) #=>6
# p (1..9).multiply_els(:+) #=>45
# p [1, 2, 3].multiply_els(4, :*) #=>24
# p (1..3).multiply_els(4, :*) #=>24
