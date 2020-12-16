require 'ostruct'
password_entries = []
valid_length_count = 0
valid_position_count = 0

File.open("input.txt", "r").each_line do |line|
  row = line.split(' ')
  password_entries << OpenStruct.new(
    min_chars: row[0].split('-').first.to_i,
    max_chars: row[0].split('-').last.to_i,
    letter: row[1].gsub(':', ''), \
    password: row[2]
  )
end

password_entries.each do |entry|
  char_size = entry.password.scan(entry.letter).size

  if char_size >= entry.min_chars && char_size <= entry.max_chars
    valid_length_count += 1
  end

  if (entry.password[entry.min_chars - 1] == entry.letter && entry.password[entry.max_chars - 1] != entry.letter) ||
    (entry.password[entry.min_chars - 1] != entry.letter && entry.password[entry.max_chars - 1] == entry.letter)
    valid_position_count += 1
  end
end

puts valid_length_count
puts valid_position_count