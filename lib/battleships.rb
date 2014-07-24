require 'sinatra/base'

require_relative './models/player'
require_relative './models/cell'
require_relative './models/board'
require_relative './models/ship'
require_relative './models/water'
require_relative './models/game'


class BattleShips < Sinatra::Base

	set :views, './views'
	enable :sessions

  get '/' do
  	erb :index
  end

  get '/new_game' do
  	erb :new_game
  end

  post '/new_player' do
  	name = params[:name]
  	session[:me] = Player.new(name: name, board: Board.new(content: Water.new))
  	@player = session[:me]
  	puts @player.name.inspect
  	erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
