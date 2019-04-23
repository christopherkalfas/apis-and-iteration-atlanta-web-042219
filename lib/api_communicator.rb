require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string)["results"]
  film_urls = nil
  film_array = []
  response_hash.each_with_index do |char, index|
    if char["name"].downcase.include?(character_name)
      film_urls = response_hash[index]["films"]
    end
  end
  if film_urls
    film_urls.each do |url|
      movie_response_string = RestClient.get(url)
      movie_response_hash = JSON.parse(movie_response_string)
      film_array << movie_response_hash
    end
  end
  film_array
end

def print_movies(films)
  puts "Films homeboy/girl was in: "
  # binding.pry
  films.each do |film|
    puts "#{film["title"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  if films != []
    print_movies(films)
  else
    puts 'no movies'
  end
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
