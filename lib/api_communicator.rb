require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_hash = json_parse(rest_request('http://www.swapi.co/api/people/'))
  character_films = find_films_by_character(response_hash, character_name)
  film_data_res = map_film_data_res(character_films)
  film_data_json = map_film_data_json(film_data_res)
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.  
end

def map_film_data_res(character_films)  
  value = character_films["films"].sort.map{|film| rest_request(film)}
end

def map_film_data_json(film_data_res)
  film_data_res.map{|response| JSON.parse(response)}
end

def rest_request(url)
  RestClient.get(url)
end

def json_parse(res)
    JSON.parse(res)
end

def find_films_by_character(results, character_name)
  results["results"].find{|character| character["name"] == character_name}  
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list  
  titles = films.map{|data| data["title"]}
  titles.each_with_index{|title, index| puts "#{index+1} #{title}"}
end

def show_character_movies(character)

  films = get_character_movies_from_api(character)  
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
