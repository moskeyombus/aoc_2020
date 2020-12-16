expenses = []
first_expense = nil

File.open("input.txt", "r").each_line do |line|
  expenses << line.to_i
end

while expenses.length.positive?
  first_expense = expenses.shift

  expenses.each_with_index do |second_expense, index|
    if first_expense + second_expense == 2020
      puts 'double expense found!'
      puts first_expense * second_expense
    end

    expenses[index..expenses.length - 1].each do |third_expense|
      if first_expense + second_expense + third_expense == 2020
        puts 'triple expense found!'
        puts first_expense * second_expense * third_expense
      end
    end
  end
end
