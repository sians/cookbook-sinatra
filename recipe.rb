class Recipe
  attr_writer :done
  attr_reader :name, :description, :prep_time
  def initialize(name, description, prep_time, done=false)
    @name = name
    @description = description
    @done = done == "true" ? true : false
    @prep_time = prep_time
  end

  def done?
    @done
  end
end
