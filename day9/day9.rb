WINDOW_LENGTH = 25.freeze
preamble_sums = []
contiguous_sums = []
number_list = []
window_min = 0
window_max = WINDOW_LENGTH - 1
current_index = WINDOW_LENGTH

File.open("input.txt", "r").each_line do |line|
  current = line.strip.to_i
  number_list << current
end

while current_index < number_list.length
  (window_min...window_max).each do |outer|
    (outer..window_max).each do |current|
      preamble_sums << number_list[outer] + number_list[current]
    end
  end

  unless preamble_sums.include?(number_list[current_index])
    puts number_list[current_index]

    number_list.each_with_index do |number, index|
      (index...number_list.length).each do |sum_counter|
        range = (index..sum_counter).map { |inner_index| number_list[inner_index] }
        if range.size > 1 && (index != sum_counter)
          if (range.sum == number_list[current_index])
            puts 'range:'
            puts range.map(&:to_s).join(',')

            puts 'min/max sum:'
            puts "#{range.min} + #{range.max} = #{range.min + range.max}"
          end
        end
      end
    end
    puts '---'
  end

  window_min += 1
  window_max += 1
  current_index += 1
  preamble_sums = []
end
