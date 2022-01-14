require_relative 'custom_enumerables'

# Each
numbers = [1, 2, 3, 4, 5]
numbers.my_each  { |item| puts item }
numbers.each  { |item| puts item }
puts ""

# Each With Index
numbers = [1, 2, 3, 4, 5]
numbers.my_each_with_index  { |item, idx| puts "#{item} | #{idx}" }
puts ""
numbers.each_with_index  { |item, idx| puts "#{item} | #{idx}" }
puts ""

# Select
numbers = [1, 2, 3, 4, 5]
p numbers.select(&:even?)
p numbers.my_select(&:even?)

# All?
p %w[ant bear cat].all? { |word| word.length >= 3 }
p %w[ant bear cat].my_all? { |word| word.length >= 3 }

p %w[ant bear cat].all? { |word| word.length >= 4 }
p %w[ant bear cat].my_all? { |word| word.length >= 4 }

# Any?
p %w[ant bear cat].any? { |word| word.length >= 3 }
p %w[ant bear cat].my_any? { |word| word.length >= 3 }
p %w[ant bear cat].any?(/d/)
p %w[ant bear cat].my_any?(/d/)
p [].any?
p [].my_any?

# None?
p %w{ant bear cat}.none? { |word| word.length == 5 }
p %w{ant bear cat}.none?(/d/)
p [nil, false, true].none?
p %w{ant bear cat}.my_none? { |word| word.length == 5 }
p %w{ant bear cat}.my_none?(/d/)
p [nil, false, true].my_none?

# Count
p ary = [1, 2, 4, 2]

p ary.count
p ary.count(2)
p ary.count { |x| x%2==0 }
p ary.my_count
p ary.my_count(2)
p ary.my_count { |x| x%2==0 }

# Map
p (1..4).map { |i| i*i }
p (1..4).map { "cat"  }

p (1..4).my_map { |i| i*i }
p (1..4).my_map { "cat"  }

# Inject
p (5..10).inject(:+)
p (5..10).inject { |sum, n| sum + n }
p (5..10).inject(1, :*)
p (5..10).inject(1) { |product, n| product * n }
p (5..10).my_inject(:+)
p (5..10).my_inject { |sum, n| sum + n }
p (5..10).my_inject(1, :*)
p (5..10).my_inject(1) { |product, n| product * n }

# Test Inject
def multiply_els(arr)
  arr.my_inject(:*)
end

p multiply_els([2,4,5])

# Map, but it uses Proc
test_proc = Proc.new { |v| v.to_s }
p (1..4).my_map(test_proc)