class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    num = num.hash
    unless self[num].include?(num)
      self[num] << num
      @count += 1
      resize! if @count > num_buckets
    end
    
  end

  def remove(num)
    num = num.hash
    deleted = self[num].delete(num)
    @count -= 1 unless deleted.nil?
  end

  def include?(num)
    num = num.hash
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    num = num.hash
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
