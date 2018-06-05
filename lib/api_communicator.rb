require 'rest-client'
require 'json'
require 'pry'

def get_character_movies(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  results = character_hash["results"]
  results.map do |x|

    if x["name"] == character
      films = x["films"]
      # binding.pry
    end
  end.flatten.compact
end
# get_character_movies("Darth Vader")

def get_character_movies_from_api(character)
  films = get_character_movies(character)
  films.map do |film|
    all_films = RestClient.get(film)
    movies = JSON.parse(all_films)
  end


end



def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.map do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
