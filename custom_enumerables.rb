module Enumerable
  def my_each
    length.times { |i| yield self[i] }
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
  end

  def my_select
    to_return = []
    my_each { |s| to_return << s if yield s}
    to_return
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
numbers = [1, 2, 3, 4, 5]
p numbers.select(&:even?)
p numbers.my_select(&:even?)
