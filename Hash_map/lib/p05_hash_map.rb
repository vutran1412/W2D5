require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    current_list = bucket(key)
    return false if current_list.empty?
    current_list.include?(key)
  end

  def set(key, val)
    current_list = bucket(key)
    if current_list.include?(key)
      current_list.update(key, val)
    else
      current_list.append(key, val)
      @count += 1
      resize! if @count > num_buckets
    end

  end

  def get(key)
    current_list = bucket(key)
    current_list.each { |node| return node.val if key == node.key }
  end

  def delete(key)
    current_list = bucket(key)
    deleted = current_list.remove(key)
    @count -= 1 unless deleted.nil?
  end

  def each(&prc)
    @store.each {|list| list.each {|node| prc.call(node.key, node.val) } }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    self.each do |k, v|
      new_store[k.hash % (num_buckets * 2)].append(k, v)
    end
    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
