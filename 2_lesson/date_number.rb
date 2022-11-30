# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 

puts 'date'
date = gets.chomp.to_i
puts 'months'
month = gets.chomp.to_s
puts 'year'
year = gets.chomp.to_i

months = { '01' => 31, '02' => 28, '03' => 31, '04' => 30, '05' => 31, '06' => 30,
           '07' => 31, '08' => 31, '09' => 30, '10' => 31, '11' => 30, '12' => 31 }

months['02'] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 4 == 0 && year % 400 == 0)

date_num = 0
months.each do |m, d|
  date_num += d if m < month
  date_num += date if m == month
end

puts date_num
