class Ship

	def initialize(size)
		@remaining_hits = size
	end

	def floating?
		remaining_hits != 0
	end

	def remaining_hits
		@remaining_hits
	end

	def hit!
		@remaining_hits -= 1
		return "That's a hit!" if floating?
		return 'Ship destroyed!!' unless floating?
	end

end

class PatrolBoat < Ship
	def initialize
		super 2
	end
end

class Submarine < Ship
	def initialize
		super 3
	end
end

class Destroyer < Ship
	def initialize
		super 4
	end
end

class Battleship < Ship
	def initialize
		super 5
	end
end

class Carrier < Ship
	def initialize
		super 6
	end
end