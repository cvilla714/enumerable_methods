require_relative '../testing.rb'

RSpec.shared_context 'mainvariables' do
  arr = to_a if self.class == Range
  arr = self if self.class == Array
  arr = to_a if self.class == Hash
end

RSpec.describe 'testing my_each' do
  include_context 'mainvariables'

  it 'compare the my_each to ech when a block is given' do
    expect([1, 2, 3, 4, 5].my_each(&proc { |n| p n.even? })).to eq([1, 2, 3, 4, 5].each(&proc { |n| p n.even? }))
  end

  it 'will compare when the number is greater than the condition' do
    expect([1, 2, 3].my_each { |x| p x > 2 }).to eq([1, 2, 3].each { |x| p x > 2 })
  end

  it 'will give back the enumerator if no block is given ' do
    expect([1, 2, 3].my_each.class).to eq([1, 2, 3].each.class)
  end
end

RSpec.describe 'testinng my_each_index' do
  include_context 'mainvariables'

  context 'will return the enumerator is no block is given ' do
    it 'check if no block is given will retun the enumerator' do
      expect([1, 2, 3].my_each_with_index.class).to eq([1, 2, 3].each_with_index.class)
    end
  end

  it 'will check when a block is given and meeting condition' do
    expect([1, 2, 3, 4, 5].my_each_with_index(&proc { |n| p n % 2 })).to eq([1, 2, 3, 4, 5].each_with_index(&proc { |n| p n % 2 }))
  end

  it 'will evaluate when a range is given' do
    expect((1..3).my_each_with_index(&proc { |x| p x > 2 })).to eq((1..3).each_with_index(&proc { |x| p x > 2 }))
  end
end
RSpec.describe 'testinng my_select' do
  include_context 'mainvariables'
  context 'will return the element that meet the criteria' do
    it 'check if the element meet the criteria' do
      expect([1,2,3,4].my_select{|x| x>2}).to eq([1,2,3,4].select{|x| x>2})
    end
  end
  it 'will evaluate when a range is given ' do
    expect((1..10).my_select { |i|  i % 3 == 0 }).to eq((1..10).select { |i|  i % 3 == 0 })
  end
  it 'will evaluate when a string is given' do
    expect([:foo, :bar].my_select { |x| x == :foo }).to eq([:foo, :bar].select { |x| x == :foo })
 end
end
RSpec.describe 'testinng my_all?' do
  include_context 'mainvariables'
  context 'will return when the block is given' do
    it 'will check when a block is given and meeting condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(%w[ant bear cat].all? { |word| word.length >= 3 })


    end 
  end
  context'will evalute when  Regex is given' do
  it 'will check the output when the Regex is given' do
    expect(%w[ant bear cat].my_all?(/t/)).to eq(%w[ant bear cat].my_all?(/t/))

   end
  end
  context 'will check if the criteria meet with class' do
  it 'will check if the elements are numbers' do
  expect([1, 3i, 3.14].my_all?(Numeric)).to eq([1, 3i, 3.14].my_all?(Numeric))
  end
  end
end
