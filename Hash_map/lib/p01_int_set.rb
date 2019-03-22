class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max)
  end

  def insert(num)
    @store[num] = true unless is_valid?(num)
    
  end

  def remove(num)
    @store[num] = false unless is_valid?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include? num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return true if self[num].include? num
    return false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      self[num] << num
      @count += 1
      resize! if @count > num_buckets
    end
    
  end

  def remove(num)
    deleted = self[num].delete(num)
    @count -= 1 unless deleted.nil?
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % (num_buckets * 2)] << el
      end
    end
    @store = new_store
  end
end
