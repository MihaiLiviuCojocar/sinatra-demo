require_relative './cell'

class Board

	def initialize(content: :water)
		@grid = create_new_grid_with(content)
	end

	def grid
		@grid
	end

	def place(ship_type, at_coordinates)
		at_coordinates.locations.each do |location|
			grid[location].content = ship_type
		end
	end

	def render_display
		rows_of_cells.each_slice(10).map { |el| el }
	end

	def nice_display
		render_display.each{|row| p row}
	end

	private

	def rows_of_cells
		grid.values.map{|cell| cell.status}
	end
	
	def create_new_grid_with(content)
		Hash[*new_grid(rows: (1..10), columns: ("A".."J"), with: content)]
	end

	def new_grid(rows: [], columns: [], with: '')
		columns.map { |letter| rows.map { |number|  new_cell_in(letter, number, with: with)} }.flatten
	end

	def new_cell_in(letter, number, with: content)
		["#{letter}#{number}", Cell.new(with) ]
	end

end