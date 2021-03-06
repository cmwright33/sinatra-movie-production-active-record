require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'rake'
require 'pry'

set :database, {adapter: "postgresql",
                database: "movie_production2",
                host: "localhost"}

# Model
class Todos < ActiveRecord::Base
  belongs_to :movie
  belongs_to :people
end
# Model
class Movies < ActiveRecord::Base
  has_many :people
  has_many :todos
end
# Model
class People < ActiveRecord::Base
  belongs_to :movie
  has_many :todos
end



# this provides you with the index page that links to each seperate page
# Controller
get '/' do
# Views
  erb :index
end

#       #
# Tasks #
#       #

# gets all the tasks
get '/todos' do
  @todos = Todo.all
erb :todos
end

# gives each individual task

get '/todo/:id' do
  @todo = Todo.find(params[:id])
erb :todo
end

# goes to the edit task
get '/todo/:id/edit' do
  @todo = Todo.find(params[:id])
erb :edit_todo
end

# posts the update back
post '/todo/:id' do
  todo = Todo.find(params[:id])
  todo.task = params[:task]
  todo.task_description = params[:task_description]
  todo.movie_id = params[:movie_id]
  todo.contact_id = params[:contact_id]
  todo.save
  redirect to "/todos/#{todo.id}"
end


# create and assign new todo
get '/create_todo' do
  @people = People.find(params[:id])
  @movies = Movie.find(params[:id])
  erb :create_todo
end

# posts the task back to
post '/create_todo' do
  todo = Todo.create(params)
  redirect to "/todo/#{guitar.id}"
  erb :todos
end



#         #
# People  #
#         #

# get all the people

get'/people' do
  @people = People.all
  erb :people
end

# get each individual person


get '/person/:id' do
  @people = People.find(params[:id])
erb :person
end


 # gives you the person information to edit
 get '/person/:id/edit' do

  @people = People.find(params[:id])
 end

#  posts the edits back to person
post '/person/:id' do
  people = People.find(params[:id])
  people.name = params[:name]
  people.occupation = params[:occupation]
  people.save
end



# creates an new person and assigns
get '/create_person' do
  erb :create_person
end

# posts the person back to people
post '/create_person' do
  person = People.create(params)
end




#        #
# Movies #
#        #

# gets the movie

get '/movies' do
  movie = Movie.all
  erb :movies
end

# gets single movie with information

get '/movie/:id' do
  movie = Movie.find(params[:id])
  erb :movie
end

# creates an new person and assigns
get '/create_movie' do
  erb :create_movie
end

# posts the person back to people
post '/create_movie' do
  movie = Movie.create(params)
end

get '/movie/:id/edit' do
  movie = Movie.find(parm[:id])
erb :edit_movie
end

post '/movie/:id' do
  movie = Movie.find(params[:id])
  movie.movie_name = params[:movie_name]
  movie.release_date = params[:release_date]
  movie.director = params[:director]
  movie.save
  redirect to "/movies/#{movie.id}"
end



