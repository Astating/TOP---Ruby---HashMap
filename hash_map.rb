# frozen_string_literal: true

require_relative 'linked_list'

# TODO
class HashMap
  PRIME_NUMBER = 31
  LOAD_FACTOR = 0.8

  attr_reader :bucket_capacity

  def initialize(bucket_capacity = 16)
    @bucket_capacity = bucket_capacity
    @buckets = Array.new(bucket_capacity) { LinkedList.new }
  end

  def hash(key)
    key.chars.reduce(0) do |hash_code, char|
      PRIME_NUMBER * hash_code + char.ord
    end % @bucket_capacity
  end

  def set(key, value)
    @buckets[hash(key)].set(key, value)
    grow_bucket_capacity_if_needed

    self
  end

  def get(key)
    @buckets[hash(key)].get(key)
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    removed = @buckets[hash(key)].remove(key)
    decrease_bucket_capacity_if_needed if removed

    removed
  end

  def length
    @buckets.sum(&:size)
  end

  def clear
    initialize
  end

  def keys
    @buckets.flat_map(&:keys)
  end

  def values
    @buckets.flat_map(&:values)
  end

  def entries
    @buckets.flat_map(&:entries)
  end

  private

  def current_load
    length.fdiv(@bucket_capacity)
  end

  def resize(capacity)
    all = entries
    initialize(capacity)
    all.each { |key_value| set(*key_value) }
  end

  def grow_bucket_capacity_if_needed
    return unless current_load > LOAD_FACTOR

    resize(@bucket_capacity * 2)
  end

  def decrease_bucket_capacity_if_needed
    return unless current_load < LOAD_FACTOR / 2 && @bucket_capacity > 16

    resize(@bucket_capacity / 2)
  end
end
