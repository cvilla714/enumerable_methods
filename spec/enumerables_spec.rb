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
