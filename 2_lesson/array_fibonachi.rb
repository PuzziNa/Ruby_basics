# Заполнить массив числами фибоначчи до 100

fibonachi = [0, 1]
last_num = 1

while last_num < 100
  last_num = fibonachi[-1] + fibonachi[-2]
  fibonachi << last_num if last_num < 100
end

puts fibonachi
