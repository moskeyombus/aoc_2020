any_total = 0
all_total = 0
current_group = []
merged_group = nil

File.open("input.txt", "r").each_line do |line|
  if line.strip.empty?
    any_total += current_group.uniq.size
    all_total += merged_group.uniq.size
    puts merged_group.uniq.size
    current_group = []
    merged_group = nil
  else
    formatted = line.strip.split('')
    current_group += formatted

    merged_group = formatted if merged_group.nil?
    merged_group &= formatted
  end
end

any_total += current_group.uniq.size
all_total += merged_group.uniq.size

puts '----'
puts any_total
puts all_total