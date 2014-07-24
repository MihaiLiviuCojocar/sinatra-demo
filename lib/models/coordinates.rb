class Coordinates

	COLUMNS = ('A'..'J').to_a
	ROWS    = (1..10).to_a

	def initialize(locations)
		@locations = locations
	end
		
	attr_reader :locations

	def columns
		locations.map { |location| location.chars[0] }
	end

	def rows
		locations.map { |location| location.chars[1..-1].join.to_i }
	end

	def rows_sequential?
		return true if same_row?
		are_sequential?(rows)
	end

	def columns_sequential?
		return true if same_column?
		are_sequential?(convert_to_numbers(columns))
	end

	def inside_grid?
		all_columns_included? && all_rows_included?
	end

	def valid?
		inside_grid? && rows_sequential? && columns_sequential?
	end

	private

	def all_columns_included?
		columns.all? { |column| COLUMNS.include?(column) }
	end

	def all_rows_included?
		rows.all? { |row| ROWS.include?(row) }
	end

	def are_sequential?(numbers)
		numbers.sort == create_range_from_array_of(numbers).to_a
	end

	def create_range_from_array_of(numbers)
		numbers = numbers.sort
		(numbers.first..numbers.last)
	end

	def convert_to_numbers(letters)
		letters.map{|letter| letter.to_i(27)}
	end

	def same_column?
		columns.uniq.length == 1
	end

	def same_row?
		rows.uniq.length == 1
	end

end