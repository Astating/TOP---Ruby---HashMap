# frozen_string_literal: true

require_relative 'hash_map'

test = HashMap.new

p({ set_entry: test.set('monkey', 4) == test })

p({ get_entry: test.get('monkey') == 4 })

p({ get_non_entry: test.get('elephant').nil? })

p({ has_key: test.has?('monkey') == true })

p({ remove_entry: test.remove('monkey') == 4 })

p({ has_key_no_longer: test.has?('monkey') == false })

p({ remove_non_key: test.remove('elephant').nil? })

p({ empty: test.length.zero? })

p({ chainable_set: test.set('monkey', 5).set('monkey', 7).set('elephant', 'blues').length == 2 })

test.clear
p({ cleared: test.length.zero? })

('AAA'..'AAZ').each_with_index { |key, value| test.set(key, value) }
p({ grew_capacity: test.bucket_capacity == 64 })

test.remove('AAA')
p({ decreased_capacity: test.bucket_capacity == 32 })

test.clear
test.set('monkey', 'love').set('elephant', 'dance').set('llama', 'fire')
p({ entries: test.entries == [%w[elephant dance], %w[monkey love], %w[llama fire]],
    keys: test.keys == test.entries.map(&:first),
    values: test.values == test.entries.map(&:last) })
