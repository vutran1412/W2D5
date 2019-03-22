class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next, self.next.prev = self.next, self.prev
  end

  def inspect
    "#{key}, #{val}"
  end
end

class LinkedList
  include Enumerable 

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail && @tail.prev == @head
    false
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end

  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next, new_node.prev = @tail, last
    last.next = new_node
    @tail.prev = new_node
    
  end

  def update(key, val)
    if self.include?(key)
      self.each do |node|
        node.val = val if node.key == key
      end
    end
  end

  def remove(key)
    deleted = nil
    self.each do |node|
      if node.key == key
        deleted = key
        node.remove
      end
    end
    deleted
  end

  def each(&prc)
    pointer = first
    while pointer != @tail
      prc.call(pointer)
      pointer = pointer.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
