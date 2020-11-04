require_relative '../testing.rb'

RSpec.shared_context 'mainvariables' do
  arr = to_a if self.class == Range
  arr = self if self.class == Array
  arr = to_a if self.class == Hash
  let(:words) { %w[dog door rod blade] }
  let(:sentence) { %w[5 dog door rod blade] }
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
      expect([1, 2, 3, 4].my_select { |x| x > 2 }).to eq([1, 2, 3, 4].select { |x| x > 2 })
    end
  end
  it 'will evaluate when a range is given ' do
    expect((1..10).my_select { |i| i % 3 == 0 }).to eq((1..10).select { |i| i % 3 == 0 })
  end
  it 'will evaluate when a string is given' do
    expect(%i[foo bar].my_select { |x| x == :foo }).to eq(%i[foo bar].select { |x| x == :foo })
  end
end
RSpec.describe 'testinng my_all?' do
  include_context 'mainvariables'
  context 'will return when the block is given' do
    it 'will check when a block is given and meeting condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(%w[ant bear cat].all? { |word| word.length >= 3 })
    end
  end
  context 'will evalute when  Regex is given' do
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

RSpec.describe 'testing my_any' do
  include_context 'mainvariables'

  context 'check the block to see if it meets the condition' do
    it 'will check the conditio inside the block' do
      expect([1, 2, 3].my_all?(&proc { |x| x > x / 5 })).to eq([1, 2, 3].all?(&proc { |x| x > x / 5 }))
    end
  end

  it 'will check if the condition meets inside a Range' do
    expect((1..3).my_all?(&proc { |x| x.even? })).to eq((1..3).all?(&proc { |x| x.even? }))
  end

  it 'will check if the elements inside the array matches the class' do
    expect([1, 2, 3].my_all?(Integer)).to eq([1, 2, 3].all?(Integer))
  end

  it 'will check if the conditions matches the Regex' do
    expect(%w[car cat].my_all?(/a/)).to eq(%w[car cat].all?(/a/))
  end

  it 'will give back false if Regex condition is not met' do
    expect(%w[car cat].my_all?(/t/)).to eq(%w[car cat].all?(/t/))
  end

  it 'will check if the element meets the criteria inside of a String array' do
    expect(%w[cat dog car].my_any?('cat')).to eq(%w[cat dog car].any?('cat'))
  end
end

RSpec.describe 'my_none method' do
  include_context 'mainvariables'

  context 'will check if the condition is met when a block is given' do
    it 'will check the block and if the condition true' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eq(%w[ant bear cat].none? { |word| word.length == 5 })
    end
  end

  it 'will return false if one element meets the criteria' do
    expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eq(%w[ant bear cat].none? { |word| word.length >= 4 })
  end

  it "will return true if the elements don't meet the Regex" do
    expect(%w[ant bear cat].my_none?(/d/)).to eq(%w[ant bear cat].none?(/d/))
  end

  it 'will give back false if one elemnt meets the Regex' do
    expect(%w[ant dog cat].my_none?(/d/)).to eq(%w[ant dog cat].none?(/d/))
  end

  context ' will evaluates classes' do
    it 'will return false if one element is equals to the class' do
      expect([1, 3.1, 42].my_none?(Float)).to eq([1, 3.1, 42].none?(Float))
    end
    it 'will return true if the block does not match argument' do
      expect(words.my_none?(5)).to eq(words.none?(5))
    end
    it 'will return false when the elements inside the block matches the argument' do
      expect(sentence.my_none?(5)).not_to eq(sentence.none?(5))
    end
  end
end
