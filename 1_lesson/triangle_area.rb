# Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (base) (a) и высоту (hight) (h) 
# по формуле: 1/2*a*h. Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

puts 'Write the height of the triangle'
hight = gets.chomp.to_f
puts 'Write the base of the triangle'
base = gets.chomp.to_f

area = 0.5 * base * hight
puts "The area of the triangle is #{area}"
