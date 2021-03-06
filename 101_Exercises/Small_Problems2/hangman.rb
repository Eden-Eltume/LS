text = File.read("hangwords.txt")

words = text.split( )
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

tries_left = chars_in_word(the_word) + 6

def guess_letter(the_word, letter, initial_array)
  if the_word.downcase.include?(letter.downcase) && initial_array.include?(letter.downcase) == false

    counter = 0
    loop do
      break if counter == the_word.length
      current_letter = the_word[counter]
      current_index = the_word.index(current_letter)

      if current_letter.downcase == letter.downcase
        initial_array.insert(counter, current_letter)
        initial_array.delete_at(counter + 1)
      end
      counter += 1
    end
    true
  elsif initial_array.include?(letter.downcase) == true
    'already'
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
prompt "The word has #{chars_in_word(the_word)} letters and you have #{chars_in_word(the_word) + 6} guesses. Take a guess. One letter at a time:"
answer_arr = []
counter = 0
loop do
  display_board(initial_array)
  prompt("What letter do you think it contains?")
  answer = gets.chomp
  answer_arr << answer
  result = guess_letter(the_word, answer, initial_array)
  if counter > 0
    clear_screen
  end
  prompt("You've guessed the following letters: #{answer_arr}")
  if result == false
    tries_left -= 1
    prompt("You have #{tries_left} tries left.")
  elsif result == 'already'
    prompt("You guessed the letter #{answer} already! No points deducted. Try again!")
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
  prompt("Sorry, the word was #{the_word}.")
  puts hanged
else
  display_board(initial_array)
  puts survived
end
