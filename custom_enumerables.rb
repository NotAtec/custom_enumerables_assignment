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
    my_each { |t| return false unless yield t}
    true
  end

  def my_any?(tester='')
    if tester == ''
      my_each { |t| return true if yield t}
      false
    else
      my_each { |t| return true if tester === t }
      false
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
p %w[ant bear cat].any? { |word| word.length >= 3 }
p %w[ant bear cat].my_any? { |word| word.length >= 3 }
p %w[ant bear cat].any?(/d/)
p %w[ant bear cat].my_any?(/d/)
p [].any?
p [].my_any?

# None?

# Count

# Map

# Inject
