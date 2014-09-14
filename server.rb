require 'sinatra/base'
require 'haml'
require './lib/player'
require './lib/game'

configure :production do
  require 'newrelic_rpm'
end

class RockPaperScissors < Sinatra::Base

enable :sessions  

  get '/' do
    haml :index
  end

  get '/new-game' do
  	haml :new_player
  end

  post '/register' do 
  	@player = params[:name]
  	haml :play	
  end


  post "/play" do
  	player = Player.new(params[:name])
  	player.picks = params[:pick]
  	computer = generate_computer
  	@game = Game.new(player, computer)
  	haml :outcome
  end

  get "/play" do 
    haml :play
  end

  def generate_computer
  	choice = ["Rock","Paper","Scissors"].sample

  	comp = Player.new("computer")
  	comp.picks = choice
  	comp
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
