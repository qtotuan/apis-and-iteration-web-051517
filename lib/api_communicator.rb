require 'rest-client'
require 'json'
require 'pry'
require_relative './character'

def get_answer(character)
  character_hash = create_character_hash_from_API
  populate_character_class(character_hash)
  find_film_by_character(character, character_hash)
end

def create_character_hash_from_API
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def populate_character_class(hash)
  hash["results"].each do |character_hash|
    Character.all << Character.new(character_hash["name"], character_hash["height"], character_hash["mass"])
  end
end

def find_film_by_character(character, hash)
  found = Character.find_character_by_name(character)
  found.add_film(hash)
  puts "-------------------"
  puts "#{character.split(" ").collect! { |e| e.capitalize }.join(" ")} appears in these movies:"
  puts found.films
end


def get_movie_from_api(movie)
  #make the web request
  all_movies = RestClient.get('http://www.swapi.co/api/films/')
  movie_hash = JSON.parse(all_movies)
  i = 0
  while i < movie_hash.length do
    if movie_hash["results"][i]["title"].downcase == movie
      characters = movie_hash["results"][i]["characters"]
    end
    i += 1
  end

    character_array = []
    characters.each do |character_url|
      result = RestClient.get(character_url)
      character_array << JSON.parse(result)
    end

    character_array

end

def parse_character_movies(films_hash)
  films_hash.each do |info_hash|
    puts info_hash["title"] + " (#{info_hash["release_date"][0..3]})"
  end
end

def parse_movie_characters(character_hash)
  character_hash.each do |info_hash|
    puts info_hash["name"] + ": eye-color ==> #{info_hash["eye_color"]}"
  end
end

# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end

def show_movie_characters(movie)
  character_hash = get_movie_from_api(movie)
  parse_movie_characters(character_hash)
end
