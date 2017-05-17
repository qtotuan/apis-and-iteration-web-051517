class Character
 attr_accessor :name, :films, :height, :mass

 @@all = []

 def initialize(name, height, mass)
   @name = name
   @height = height
   @mass = mass
   @films = []
 end

  def self.all
    @@all
  end

  def add_film(character_hash)
    i = 0
    while i < character_hash.length do
      if character_hash["results"][i]["name"].downcase == @name.downcase
        films = character_hash["results"][i]["films"]
      end
      i += 1
    end

    films_array = []
    films.each do |film_url|
      result = RestClient.get(film_url)
      films_array << JSON.parse(result)
    end

    films_array.each do |film_hash|
      @films << film_hash["title"]
    end

  end

 def self.find_character_by_name name
    self.all.detect { |character| character.name.downcase == name }
  end

end

# class Api_methods
#
# all_characters = RestClient.get('http://www.swapi.co/api/people/')
# character_hash = JSON.parse(all_characters)
# character_hash["results"].each {|character| @@all << Character.new(character['name'])}
#
# end
