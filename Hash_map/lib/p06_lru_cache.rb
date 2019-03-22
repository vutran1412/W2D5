require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require "byebug"

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # debugger
    if @map.include?(key)
      update_node!(@map[key])
    else
      calc!(key)
      if count > @max
        eject!
      end
      return @map[key].val
    end

    
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    # debugger
    @store.append(key, @prc.call(key))
    @map[key] = @store.last
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key, node.val)
    @map[node.key] = @store.last
  end

  def eject!
    # debugger
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
