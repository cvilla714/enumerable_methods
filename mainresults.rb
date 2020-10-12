# frozen_string_literal: true

require_relative './methods.rb'

# arrays of strings
cities = %w[montreal manhattan jersey atlanta hollywood]
# array or numbers
totals = [-10, 20, 30, 40, 50, 8, 100]
tot_inject = [1, 3, 5, 7, 9]
my_array = [5, 9, 3, 2, 4, 1]

# calling each module
my_each(my_array) { |index| p index * 2 }

my_each_with_index(my_array) do |item, index|
  p item if index == 2
end

p my_select(my_array, &:positive?)
p my_all(my_array, &:positive?)
p my_any(my_array, &:negative?)
p my_none(cities) { |index| index.length > 5 }
my_count(totals) { puts "the number of items is #{totals.length}" }
my_map(totals) { |num| puts num * 3 }
p my_inject(tot_inject) { [1, 3, 5, 7, 9] }
p multiply_els(tot_inject) { [1, 3, 5, 7, 9] }
over_forty = proc { |num| num >= 40 }
p group_over_forty = my_select(totals, &over_forty)
my_map_proc(totals) { p group_over_forty }
