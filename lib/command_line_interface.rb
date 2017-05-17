def welcome
  puts "Hi, do you want to look for characters or movies?"
end

def movie_or_character?
  gets.chomp.downcase
end

def get_movie_from_user
  puts "Please choose a movie:"
  puts ""
  puts "Return of the Jedi"
  puts "A New Hope"
  puts "Attack of the Clones"
  answer = gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end

def get_character_from_user
  puts "please enter a character"
  answer = gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
