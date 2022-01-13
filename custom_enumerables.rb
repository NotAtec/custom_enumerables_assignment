module Enumerable
  def my_each
    len = self.length
    len.times { |i| yield self[i] }
    yield # Numbers value [index]
  end
end

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
numbers.my_each  { |item| puts item }
numbers.each  { |item| puts item }
