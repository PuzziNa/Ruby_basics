# Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара 
# (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет 
# "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, 
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 

answer = 0
hash = {}

loop do
  puts 'What do you want to buy?'
  answer = gets.chomp.downcase.to_s
  break if answer == 'stop'

  puts 'Quantity'
  quantity = gets.chomp.to_f
  puts 'Price'
  price = gets.chomp.to_f
  hash[answer] = [quantity, price]
end
puts hash

# Также вывести итоговую сумму за каждый товар.
product_sum = []
sum = 0
puts 'Total price of each product:'
hash.each do |key, value|
  sum = value[0] * value[1]
  puts "#{key} - #{sum} dollars"
  product_sum << sum
end

# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
puts "Total price #{product_sum.sum} dollars"
