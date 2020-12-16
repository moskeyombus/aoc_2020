@commands = []

File.open("input.txt", "r").each_line do |line|
  line = line.strip
  @commands << {
    command: line.split(' ').first,
    number: line.split(' ').last.to_i,
    visited: false
  }
end

def swap_commands(current, index)
  if current[:command] == 'nop'
    @commands[index][:command] = 'jmp'
  elsif current[:command] == 'jmp'
    @commands[index][:command] = 'nop'
  end
end

def execute_program
  accumulator = 0
  program_index = 0
  running = true

  @commands.each { |command| command[:visited] = false }

  while running
    completed = true if program_index == @commands.length

    if completed || @commands[program_index][:visited]
      running = false
      next
    end

    current = @commands[program_index]
    @commands[program_index][:visited] = true

    if current[:command] == 'nop'
      program_index += 1
    elsif current[:command] == 'acc'
      accumulator += current[:number]
      program_index += 1
    elsif current[:command] == 'jmp'
      program_index += current[:number]
    end
  end

  { completed: completed, accumulator: accumulator }
end

def evaluate_programs
  swap_index = 0
  running = true

  while running
    if swap_index == @commands.length
      running = false
      next
    end

    current = @commands[swap_index]
    swap_commands(current, swap_index)
    output = execute_program

    if output[:completed]
      running = false
      next
    end

    swap_commands(current, swap_index)
    swap_index += 1
  end

  output
end

puts "Accumulator when repeat occurs:"
output = execute_program
puts output[:accumulator]

puts "Accumulator when repaired:"
output = evaluate_programs
puts output[:accumulator]
