# frozen_string_literal: true

require_relative './methods.rb'

# arrays of strings
cities = %w[montreal manhattan jersey atlanta hollywood]
# array or numbers
totals = [-10, 20, 30, 40, 50, 8, 100]
tot_inject = [1, 3, 5, 7, 9]
my_array = [5, 9, 3, 2, -4, 1]

# calling each module
my_array.my_each { |index| p index * 2 }

my_array.my_each_with_index do |item, index|
  p item if index == 2
end

p my_array.my_select(&:positive?)

p my_array.my_all(&:positive?)

p my_array.my_any(&:negative?)

cities.my_none { |index| index.length > 10 }

totals.my_count { puts "the number of items is #{totals.length}" }

totals.my_map { |num| puts num * 3 }

tot_inject.my_inject { [1, 3, 5, 7, 9] }

tot_inject.multiply_els { [1, 3, 5, 7, 9] }

over_forty = proc { |num| num >= 40 }

group_over_forty = totals.my_select(&over_forty)

totals.my_map_proc { p group_over_forty }
