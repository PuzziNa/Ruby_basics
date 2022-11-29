# Идеальный вес.Программа запрашивает у пользователя имя и рост и 
# выводит идеальный вес по формуле (<рост> - 110) * 1.15, 
# после чего выводит результат пользователю на экран с 
# обращением по имени. Если идеальный вес получается отрицательным, 
# то выводится строка "Ваш вес уже оптимальный"

puts 'What is your name?'
name = gets.chomp
puts 'How tall are you?'
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

puts "Hello, #{name}. Your ideal weight is #{ideal_weight}"
