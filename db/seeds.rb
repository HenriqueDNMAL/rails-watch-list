require 'net/http'
require 'uri'
require 'json'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

url = URI('https://tmdb.lewagon.com/movie/top_rated')
response = Net::HTTP.get_response(url)

# If the request was successful, the response will have a 200 status
if response.is_a?(Net::HTTPSuccess)
  # Parse the response body as JSON
  result = JSON.parse(response.body)

  # Assuming 'results' is an array of movies
  top_rated_movies = result['results']

  top_rated_movies.each do |movie_data|
    Movie.create(
      title: movie_data['title'],
      overview: movie_data['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}",
      rating: movie_data['vote_average'].to_f
    )
  end
end
