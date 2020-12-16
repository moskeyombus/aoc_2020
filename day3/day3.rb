require 'ostruct'

row_number = 0
slope_tracker = []

[ [1,1],[3,1],[5,1],[7,1],[1,2] ].each do |slope|
  slope_tracker << OpenStruct.new(
    x_slope: slope[0],
    y_slope: slope[1],
    current_x: 0,
    current_y: 0,
    tree_count: 0
  )
end

File.open("input.txt", "r").each_line do |line|
  built_line = ''
  100.times { built_line += line.strip }

  slope_tracker.each do |tracker|
    if row_number == tracker.current_y
      if built_line[tracker.current_x] == '#'
        tracker.tree_count += 1
      end

      tracker.current_y += tracker.y_slope
      tracker.current_x += tracker.x_slope
    end
  end

  row_number +=1
end

puts slope_tracker.map(&:tree_count)
puts '---'
puts slope_tracker.map(&:tree_count).inject(:*)
