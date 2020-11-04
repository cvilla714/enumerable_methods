# rubocop:disable Layout/LineLength
require_relative '../testing'

RSpec.shared_context 'mainvariables' do
  let(:words) { %w[dog door rod blade] }
  let(:sentence) { %w[5 dog door rod blade] }
  let(:ary) { [3, 3, 3, 2, 4, 2] }
  let(:str) { %w[luigui mario boozer luffy zorro jinbei] }
  let(:longest) { %w[cat sheep bear biggest] }
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
RSpec.describe 'my_count method' do
  include_context 'mainvariables'
  context 'will check number of elements are same' do
    it 'will check the number of elements in the arrays ' do
      expect(ary.my_count).to eq(ary.count)
    end
  end
  it 'will check string of elements in the arrays' do
    expect(str.my_count).to eq(str.count)
  end
  it ' will check how many times arguments matches ' do
    expect(ary.my_count(3)).to eq(ary.count(3))
  end
  it 'will check how many time the logic will display' do
    expect(ary.my_count(&:even?)).to eq(ary.count(&:even?))
  end
end
RSpec.describe 'my_map method' do
  include_context 'mainvariables'
  context 'check the range of the arrays' do
    it ' will check the range of the elements' do
      expect((1..4).my_map { |i| i * 2 }).to eq((1..4).map { |i| i * 2 })
    end
  end
  it ' will check when the block is not given' do
    expect((1..4).my_map { 'cat' }).to eq((1..4).map { 'cat' })
  end
  it ' will execute the proc when the proc is in the bloc' do
    expect([1, 2, 3].my_map(&proc { |x| x % 2 })).to eq([1, 2, 3].my_map(&proc { |x| x % 2 }))
  end
end

RSpec.describe 'my_inject method' do
  include_context 'mainvariables'

  context 'will evalute the range with the given symbol' do
    it 'performs the operation indicated by the given symbol' do
      expect((5..10).my_inject(:+)).to eq((5..10).inject(:+))
    end
  end
  it 'will execute the block' do
    expect((5..10).my_inject { |sum, n| sum + n }).to eq((5..10).inject { |sum, n| sum + n })
  end
  it 'will perform the two operations using both arguments' do
    expect((5..10).my_inject(2, :*)).to eq((5..10).inject(2, :*))
  end
  it 'will perform the opeartion based on the argument and the block' do
    expect((5..10).my_inject(2) { |product, n| product * n }).to eq((5..10).inject(2) { |product, n| product * n })
  end
  it 'will return the longst word in a string array' do
    expect(longest.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq(longest.inject { |memo, word| memo.length > word.length ? memo : word })
  end
end

RSpec.describe 'multiply_els method' do
  include_context 'mainvariables'

  context 'evaluate that the myinject method performs inside the multiply_els' do
    it 'return the value of performing the operation' do
      expect(multiply_els([2, 2, 3, 2])).to eq(24)
    end
  end
end
# rubocop:enable Layout/LineLength
