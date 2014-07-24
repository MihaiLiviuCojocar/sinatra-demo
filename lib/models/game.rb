class Game

	def initialize(player_one: :player_one, player_two: :player_two)
		@player_one = player_one
		@player_two = player_two
	end

	attr_reader :player_one, :player_two

	def deploy_ships_for(player)
		until player.ships_to_deploy.empty?
			player.board.nice_display
			ship_to_be_deployed = player.ships_to_deploy.pop
			puts "#{player.name}! Where do you want to deploy your #{ship_to_be_deployed.class.to_s}, which is #{ship_to_be_deployed.remaining_hits} squares long?"
			at_coordinates = get_coordinates_from_player			
			while at_coordinates.locations.length != ship_to_be_deployed.remaining_hits || !at_coordinates.valid? || at_coordinates.locations.any?{|location| player.board.grid[location].part_of_ship_here? }
				puts "Be careful! The ship is #{ship_to_be_deployed.remaining_hits} long,the coordinates have to be sequential and you must not have ships on top of eachother!!" 
				at_coordinates = get_coordinates_from_player
			end
			player.board.place(ship_to_be_deployed, at_coordinates)
		end
	end

	def has_ships_floating?(player)
		player.board.grid.values.any?{|cell| cell.status == 'S'}
	end

	def fight!
		deploy_ships_for(player_one)
		puts "Player #{player_one.name}! You finished deploying your ships! "
		puts "Hit return when you(#{player_two.name}) want to begin deploying your ships!"
		gets
		deploy_ships_for(player_two)
		puts "Player #{player_two.name}! You finished deploying your ships! "
		puts "The Game will begin NOW!!! Hit return when ready!!"
		gets
		while has_ships_floating?(player_one) || has_ships_floating?(player_two)
			puts "#{player_one.name}! Where do you want to shoot?"
			at_location = gets.chomp
			puts player_one.shoot_at(player_two.board, at_location)
			puts "#{player_two.name} turn to shoot! Hit return when ready!"
			gets
			puts "#{player_two.name}! Where do you want to shoot?"
			at_location = gets.chomp
			puts player_two.shoot_at(player_one.board, at_location)
		end
	end

	private

	def get_coordinates_from_player
		Coordinates.new(gets.chomp.split)
	end

end