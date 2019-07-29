require 'csv'
require_relative 'recipe'
require 'pry-byebug'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path) do |row|
      recipe = Recipe.new(row[0], row[1], row[2], row[3])
      # binding.pry
      @recipes << recipe
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def save_recipes
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |r|
        csv << [r.name, r.description, r.prep_time, r.done?]
      end
    end
  end

  def update_recipe(recipe_index)
    @recipes[recipe_index].done = true
    save_recipes
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_recipes
  end
end
