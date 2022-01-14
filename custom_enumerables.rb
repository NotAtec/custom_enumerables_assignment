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
