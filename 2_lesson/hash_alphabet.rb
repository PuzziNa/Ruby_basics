# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

letters = ('a'..'z')
vowels = ['a', 'e', 'i', 'o', 'u', 'y']

vowel_num = {}

letters.each.with_index(1) do |letter, index|
  vowel_num[letter] = index if vowels.include?(letter)
end

puts vowel_num
