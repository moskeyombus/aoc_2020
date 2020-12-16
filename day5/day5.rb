seat_ids = []
my_seat = nil

File.open("input.txt", "r").each_line do |line|
  row_string = line[0..6].gsub('F','0').gsub('B','1')
  col_string = line[7..9].gsub('L','0').gsub('R','1')

  seat_ids << row_string.to_i(2) * 8 + col_string.to_i(2)
end

seat_ids.sort!

seat_ids.each_with_index do |seat, index|
  if index > 0 && index < seat_ids.length - 1 && my_seat.nil?
    previous_seat = seat_ids[index - 1]
    next_seat = seat_ids[index + 1]
    puts seat
    my_seat = seat + 1 if (next_seat - previous_seat) == 3
  end
end

puts '---'
puts seat_ids.max
puts my_seat