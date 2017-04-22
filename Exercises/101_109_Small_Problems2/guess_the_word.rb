words = %w(first second third fourth fifth sixth seventh eight ten eleven twelve)
the_word = words.sample

def prompt(word)
  puts ">>> #{word}"
end


def chars_in_word(word)
  word.chars.count
end

initial_array = []

def initial_board(the_word, initial_array)
  chars_in_word(the_word).times do
    initial_array << '_'
  end
end

tries_left = chars_in_word(the_word)

def guess_letter(the_word, letter, initial_array)
  if the_word.include?(letter)
    index_of_letter = the_word.rindex(letter)
    initial_array.insert(index_of_letter, letter)
    initial_array.delete_at(index_of_letter+1)
    true
  else
    prompt("Your guess was wrong!")
    false
  end
end

def display_board(initial_array)
  for el in initial_array
    print el
  end
  puts " "
end

def clear_screen
  system("clear") || system("cls")
end

initial_board(the_word, initial_array)
prompt "The word has #{chars_in_word(the_word)} letters and you also have #{chars_in_word(the_word)} guesses. Guess them one letter at a time:"
counter = 0
loop do
  display_board(initial_array)
  prompt("What letter do you think it contains?")
  answer = gets.chomp
  result = guess_letter(the_word, answer, initial_array)
  if counter > 0
    clear_screen
  end
  if result == false
    tries_left -= 1
    prompt("Wrong. You have #{tries_left} tries left.")
  else
    prompt("Good guess!")
  end
  break if tries_left == 0 || initial_array.include?('_') == false
  counter += 1
end

hanged = <<HANG
HANGED, YOU LOST!
+---+-
|   |
|   0
|   |\\
|   /\\
-+----------
HANG

survived = <<WIN
YOU WON!
 (@)
^\\|
  |/^
____|_____
WIN

if tries_left == 0
  puts hanged
else
  puts survived
end
