# Récupère l'input et la transforme en heightmap.
def get_heightmap
	heightmap = []
	File.readlines('input.txt').each do |line|
		row = []
		line.split("").each do |digit|
			if digit.match(/[0-9]/)  # on évite le caractère newline
				row.append(Integer(digit))
			end
		end
		heightmap.append(row)
	end
	heightmap
end

# Récupérer les bassins existants au sein de la heightmap sur base des points bas.
def get_basins(heightmap)
	basins = []
	heightmap.each_with_index do |row, row_index|
		row.each_with_index do |digit, digit_index|
			is_lower = true
			# Check haut
			if row_index > 0
				is_lower = digit < heightmap.at(row_index-1).at(digit_index)
			end
			# Check bas
			if is_lower && row_index+1 < heightmap.length()
				is_lower = digit < heightmap.at(row_index+1).at(digit_index)
			end
			# Check gauche
			if is_lower && digit_index > 0
				is_lower = digit < row.at(digit_index-1)
			end
			# Check droite
			if is_lower && digit_index+1 < row.length()
				is_lower = digit < row.at(digit_index+1)
			end
			# Si c'est un point bas, on ajoute son niveau de risque à l'ensemble
			if is_lower
				basins.append(get_basin(heightmap, [row_index, digit_index], []))
			end
		end
	end
	basins
end

# Récupère un bassin au sein de l'heightmap depuis un point bas.
def get_basin(heightmap, low_point, basin)
	basin.append(low_point)
	y = low_point[0]
	x = low_point[1]
	# Check gauche
	if x-1 >= 0 && heightmap[y][x-1] != 9 && !basin.include?([y, x-1])
		get_basin(heightmap, [y, x-1], basin)
	end
	# Check droite
	if x+1 < heightmap[y].length() && heightmap[y][x+1] != 9 && !basin.include?([y, x+1])
		get_basin(heightmap, [y, x+1], basin)
	end
	# Check haut
	if y-1 >= 0 && heightmap[y-1][x] != 9 && !basin.include?([y-1, x])
		get_basin(heightmap, [y-1, x], basin)
	end
	# Check bas
	if y+1 < heightmap.length() && heightmap[y+1][x] != 9 && !basin.include?([y+1, x])
		get_basin(heightmap, [y+1, x], basin)
	end
	basin
end


basins_size = get_basins(get_heightmap).map {|basin| basin.length()}.sort
puts "Multiplication de la taille des trois derniers bassins = #{basins_size.slice(basins_size.length()-3, basins_size.length()-1).inject(:*)}"