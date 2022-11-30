# Заполнить массив числами от 10 до 100 с шагом 5
array = []
number = 0
until number == 100 do 
  number += 5
  array << number
end

puts array
