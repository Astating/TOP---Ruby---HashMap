class Node
  attr_accessor :key_value, :next_node

  def initialize(key_value, next_node = nil)
    @key_value = key_value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :root

  @root = nil

  private

  def append(key_value)
    if @root.nil?
      @root = Node.new(key_value)
    else
      tail.next_node = Node.new(key_value)
    end
  end

  def prepend(key_value)
    @root = Node.new(key_value, @root)
  end

  def insert_at(key_value, index)
    return prepend(key_value) if index.zero?

    prev_node = at(index - 1)
    return unless prev_node

    prev_node.next_node = Node.new(key_value, prev_node.next_node)
  end

  def remove_at(index)
    return @root = @root&.next_node if index.zero?

    prev_node = at(index - 1)
    return unless prev_node&.next_node

    prev_node.next_node = prev_node.next_node.next_node
  end

  

  def head
    @root
  end

  def tail
    return unless @root

    node = @root
    node = node.next_node while node.next_node

    node
  end

  def at(index)
    node = @root

    index.times do
      return unless node

      node = node&.next_node
    end

    node
  end

  def pop
    if @root&.next_node.nil?
      @root = nil
      return
    end

    node = @root
    node = node.next_node while node&.next_node&.next_node

    node.next_node = nil
  end

  public

  def set(key, value)
    node = @root

    while node
      node.key_value = [key, value] and return if node.key_value[0] == key

      node = node&.next_node
    end

    prepend([key, value])
  end

  def get(key)
    node = @root

    while node
      return node.key_value[1] if node.key_value[0] == key

      node = node&.next_node
    end

    nil
  end

  def remove(key)
    node = @root
    index = 0

    while node
      remove_at(index) and return if node.key_value[0] == key

      index += 1
      node = node.next_node
    end

    nil
  end

  def size
    node = @root
    size = 0

    while node
      size += 1
      node = node.next_node
    end

    size
  end

  def keys
    node = @root
    keys = []

    while node&.key_value
      keys << node.key_value[0]

      node = node&.next_node
    end

    keys
  end

  def values
    node = @root
    values = []

    while node&.key_value
      values << node.key_value[1]

      node = node&.next_node
    end

    values
  end

  def entries
    node = @root
    entries = []

    while node&.key_value
      entries << node.key_value

      node = node&.next_node
    end
  
  entries
  end

  def to_s
    node = @root
    string = ''

    until node&.value.nil?
      string += "( #{node.key_value[0]}: #{node.key_value[1]} ) -> "
      node = node.next_node
    end

    string + 'nil'
  end
end
