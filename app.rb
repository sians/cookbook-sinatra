require_relative "cookbook"
require_relative "recipe"

require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  recipe = Recipe.new(params["recipe_name"], params["recipe_description"], params["prep_time"])
  cookbook.add_recipe(recipe)
  cookbook.save_recipes
  redirect '/'
end

get '/destroy/:index' do
  cookbook.remove_recipe(params["index"].to_i)
  redirect '/'
end
