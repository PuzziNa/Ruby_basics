# Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, 
# является ли треугольник прямоугольным right triangle (используя теорему Пифагора www-formula.ru), 
# равнобедренным isosceles triangle (т.е. у него равны любые 2 стороны)  или равносторонним 
#equilateral triangle (все 3 стороны равны) и 
# выводит результат на экран. Подсказка: чтобы воспользоваться теоремой Пифагора, 
# нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате 
# с суммой квадратов двух остальных сторон. Если все 3 стороны равны, 
# то треугольник равнобедренный и равносторонний, но не прямоугольный.

puts "Write 'a' side of the triangle:"
a = gets.chomp.to_f
puts "Write 'b' side of the triangle:"
b = gets.chomp.to_f
puts "Write 'c' side of the triangle:"
c = gets.chomp.to_f

if a == b && a == c
  puts 'The triangle is isosceles and equilateral'
elsif (a == b && a != c) || (a == c && a != b) || (b == c && b != a)
  puts 'The triangle is isosceles'
elsif (a**2 + b**2) == c**2 || (a**2 + c**2) == b**2 || (c**2 + b**2) == a**2
  puts 'The triangle is right'
else
  puts 'The triangle is not isosceles, equilateral or right'
end