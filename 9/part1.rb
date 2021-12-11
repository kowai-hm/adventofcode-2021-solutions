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

# Récupérer les points bas. Ce sont les points dont les points adjacents sont tous plus hauts.
def get_low_points(heightmap)
	risk_sum = 0
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
				risk_sum += digit+1
			end
		end
	end
	risk_sum
end


puts "Somme des niveaux de risque des points bas : #{get_low_points(get_heightmap)}"