module Enumerable
  def my_each
    length.times { |i| yield self[i] }
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
  end

  def my_select
    to_return = []
    my_each { |s| to_return << s if yield s }
    to_return
  end

  def my_all?
    my_each { |t| return false unless yield t }
    true
  end

  def my_any?(tester = '')
    if block_given?
      my_each { |t| return true if yield t }
    else
      my_each { |t| return true if tester === t }
    end
    false
  end

  def my_none?(tester = '')
    if block_given?
      my_each { |t| return false if yield t }
    elsif tester != ''
      my_each { |t| return false if tester === t }
    elsif my_any? { |t| t == true }
      return false
    end
    true
  end

  def my_count(tester = '')
    if block_given?
      my_select { |t| yield t }.length
    elsif tester != ''
      my_select { |t| t == tester}.length
    else
      length
    end
  end

  def my_map
    if self === Array || self === Hash
      arr = self
    else
      arr = to_a
    end

    to_return = []
    arr.my_each { |val| to_return << yield(val) }
    to_return
  end

  def my_inject(start = '', enumerator = '')
    if self === Array || self === Hash
      arr = self
    else
      arr = to_a
    end

    memo = inject_set_memo(start, arr)
    arr.shift if memo == arr[0]
    enum = inject_set_enum(start, enumerator)

    if block_given?
      arr.my_each { |val| memo = yield(memo, val) }
    else
      arr.my_each { |val| memo = memo.send(enum, val)}
    end
    memo
  end

  def inject_set_memo(start, arr)
    if Integer === start
      start
    else
      arr[0]
    end
  end

  def inject_set_enum(start, enumerator)
    if Symbol === start
      start
    else
      enumerator
    end
  end
end

# Each
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each  { |item| puts item }
# numbers.each  { |item| puts item }
# puts ""

# Each With Index
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each_with_index  { |item, idx| puts "#{item} | #{idx}" }
# puts ""
# numbers.each_with_index  { |item, idx| puts "#{item} | #{idx}" }
# puts ""

# Select
# numbers = [1, 2, 3, 4, 5]
# p numbers.select(&:even?)
# p numbers.my_select(&:even?)

# All?
# p %w[ant bear cat].all? { |word| word.length >= 3 }
# p %w[ant bear cat].my_all? { |word| word.length >= 3 }

# p %w[ant bear cat].all? { |word| word.length >= 4 }
# p %w[ant bear cat].my_all? { |word| word.length >= 4 }

# Any?
# p %w[ant bear cat].any? { |word| word.length >= 3 }
# p %w[ant bear cat].my_any? { |word| word.length >= 3 }
# p %w[ant bear cat].any?(/d/)
# p %w[ant bear cat].my_any?(/d/)
# p [].any?
# p [].my_any?

# None?
# p %w{ant bear cat}.none? { |word| word.length == 5 }
# p %w{ant bear cat}.none?(/d/)
# p [nil, false, true].none?
# p %w{ant bear cat}.my_none? { |word| word.length == 5 }
# p %w{ant bear cat}.my_none?(/d/)
# p [nil, false, true].my_none?

# Count
# p ary = [1, 2, 4, 2]

# p ary.count
# p ary.count(2)
# p ary.count { |x| x%2==0 }
# p ary.my_count
# p ary.my_count(2)
# p ary.my_count { |x| x%2==0 }

# Map
# p (1..4).map { |i| i*i }
# p (1..4).map { "cat"  }

# p (1..4).my_map { |i| i*i }
# p (1..4).my_map { "cat"  }

# Inject
# p (5..10).inject(:+)
# p (5..10).inject { |sum, n| sum + n }
# p (5..10).inject(1, :*)
# p (5..10).inject(1) { |product, n| product * n }
# p (5..10).my_inject(:+)
# p (5..10).my_inject { |sum, n| sum + n }
# p (5..10).my_inject(1, :*)
# p (5..10).my_inject(1) { |product, n| product * n }

# Test Inject
def multiply_els(arr)
  arr.my_inject(:*)
end

p multiply_els([2,4,5])
