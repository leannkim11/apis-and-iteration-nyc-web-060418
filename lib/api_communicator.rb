require 'rest-client'
require 'json'
require 'pry'

# def get_next_page(hash)
#   url = hash["next"]
#
#   all_characters = RestClient.get(url)
#   character_hash = JSON.parse(all_characters)
#
# end

def get_character_movies(character)
  films = []
  api_link = "http://www.swapi.co/api/people/"

  while films.length == 0
    all_characters = RestClient.get(api_link)
    character_hash = JSON.parse(all_characters)

    results = character_hash["results"]
    # p results
    results.map do |x|

      if character == x["name"]
        films = x["films"]
      end
    end
    api_link = character_hash["next"]
    # p api_link
  end
  return films
end


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
