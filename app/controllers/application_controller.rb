class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # get '/' do
  #   erb :index
  # end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
#<-----New Item create
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.new
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    @recipe.id = Recipe.last.id

    redirect to("/recipes/#{@recipe.id}")
  end
#<-------Show page
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

#<------Update process
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.update(name: @recipe.name, ingredients: @recipe.ingredients, cook_time: @recipe.cook_time)
    redirect to("/recipes/#{@recipe.id}")
  end

#<--delete from db
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect to('/recipes')
  end
end
