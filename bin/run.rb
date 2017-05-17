#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
choice = movie_or_character?
if choice == "movies" || choice == "movie"
  movie = get_movie_from_user
  show_movie_characters(movie)
elsif choice == "character"
  character = get_character_from_user
  get_answer(character)
  # get_character_movies_from_api(character)
else
  puts "Sorry, did not get your input... Try again"
end
