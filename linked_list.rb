class Node
  attr_accessor :key_value, :next_node

  def initialize(key_value, next_node = nil)
    @key_value = key_value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :root

  def initialize
    @root = nil
  end

  def set(key, value)
    node = find_node_by_key(key)

    if node
      node.key_value[1] = value
    else
      prepend([key, value])
    end

    self
  end

  def get(key)
    find_node_by_key(key)&.key_value&.at(1)
  end

  def remove(key)
    if @root&.key_value&.at(0) == key
      removed = @root.key_value[1]
      @root = @root.next_node
      return removed
    end

    prev_node = find_node { |n| n&.next_node&.key_value&.at(0) == key }

    return nil unless prev_node

    removed = prev_node.next_node.key_value[1]

    prev_node.next_node = prev_node.next_node.next_node

    removed
  end

  def size
    entries.length
  end

  def keys
    map_nodes { |n| n.key_value[0] }
  end

  def values
    map_nodes { |n| n.key_value[1] }
  end

  def entries
    map_nodes(&:key_value)
  end

  private

  def prepend(key_value)
    @root = Node.new(key_value, @root)
  end

  def find_node
    node = @root

    while node
      return node if yield(node)

      node = node.next_node
    end

    nil
  end

  def find_node_by_key(key)
    find_node { |n| n.key_value[0] == key }
  end

  def map_nodes
    node = @root
    result = []

    while node
      result << yield(node)
      node = node.next_node
    end

    result
  end
end
