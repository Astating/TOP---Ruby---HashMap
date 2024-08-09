# frozen_string_literal: true

require_relative 'linked_list'

# TODO
class HashMap
  PRIME_NUMBER = 31
  LOAD_FACTOR = 0.75

  def initialize(bucket_capacity = 16)
    @bucket_capacity = bucket_capacity
    @buckets = Array.new(bucket_capacity) { LinkedList.new }
  end

  def hash(key)
    key.chars.reduce(0) do |sum, char|
      sum + PRIME_NUMBER * sum + char.ord
    end % @bucket_capacity
  end

  def set(key, value)
    @buckets[hash(key)].set(key, value)
    grow_bucket_capacity_if_needed
  end

  def get(key)
    @buckets[hash(key)].get(key)
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    @buckets[hash(key)].remove(key)
    decrease_bucket_capacity_if_needed
  end

  def length
    @buckets.sum(&:size)
  end

  def clear
    initialize()
  end

  def keys
    @buckets.reduce([]) { |acc, bucket| acc.push(*bucket.keys) }
  end

  def values
    @buckets.reduce([]) { |acc, bucket| acc.push(*bucket.values) }
  end

  def entries
    @buckets.reduce([]) { |acc, bucket| acc.push(*bucket.entries) }
  end
  
  private

  def load
    length / @bucket_capacity
  end

  def grow_bucket_capacity_if_needed
    return unless load > LOAD_FACTOR

    oldEntries = entries
    initialize(@bucket_capacity * 2)
    oldEntries.each { |key_value| set(*key_value) }
  end

  def decrease_bucket_capacity_if_needed
    return unless load < LOAD_FACTOR / 2 && @bucket_capacity > 16

    oldEntries = entries
    initialize(@bucket_capacity / 2)
    oldEntries.each { |key_value| set(*key_value) }
  end
end
