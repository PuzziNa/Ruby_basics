# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. equation coefficient
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
# и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
# Если D > 0, то выводим дискриминант и 2 корня
# Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
# Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru).
# Для вычисления квадратного корня, нужно использовать

puts 'Write a coefficient:'
a = gets.chomp.to_f
puts 'Write b coefficient:'
b = gets.chomp.to_f
puts 'Write c coefficient:'
c = gets.chomp.to_f

puts "Task is to solve the equation: #{a} x 2 + #{b}x — #{c} = 0"

d = b**2 - (4 * a * c)

if d.positive?
  d_root = Math.sqrt(d)
  x1 = (- b + d_root) / (2 * a)
  x2 = (- b - d_root) / (2 * a)
  puts "x1 = #{x1}, x2 = #{x2}"
elsif d.zero?
  x = 0 - b / (2 * a)
  puts "x1 = x2 = #{x}"
else
  puts 'Thete is no roots'
end
