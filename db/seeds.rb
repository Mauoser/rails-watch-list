# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
top_movies = JSON.parse(movies_serialized)
base_url = "https://image.tmdb.org/t/p/w500"
results = top_movies["results"]

results.take(10).each do |result|
  Movie.create(title: result["title"], overview: result["overview"], poster_url: base_url + result["poster_path"], rating: result["vote_average"])
end
