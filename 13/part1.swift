import Foundation

// Permet l'indexation facile des chaînes
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

struct Instruction {
	let foldAxis: String
	let coordinate: Int
	
	init(array: Array<String>) {
		foldAxis = array[0]
		coordinate = Int(array[1])!
	}
}

struct Coordinate: Hashable {
	var x: Int
	var y: Int
	
	init(array: Array<Int>) {
		x = array[0]
		y = array[1]
	}
}

func getFileContent(filename: String) -> Array<String> {
	let contents = try! String(contentsOfFile: filename)
	let lines = contents.split{ $0.isNewline }
	return lines.map {String($0)}
}

func fold(coordinates: inout Array<Coordinate>, instructions: Array<Instruction>) {
	for i in coordinates.indices {
		if(instructions[0].foldAxis == "y" && coordinates[i].y > instructions[0].coordinate) { // pli horizontal
			coordinates[i].y = instructions[0].coordinate*2 - coordinates[i].y
		} else if(instructions[0].foldAxis == "x" && coordinates[i].x > instructions[0].coordinate) { // pli vertical
			coordinates[i].x = instructions[0].coordinate*2 - coordinates[i].x
		}	
	}
	coordinates = Array(Set(coordinates))
}

let fileContent = getFileContent(filename: "input.txt")

var coordinates = fileContent
					.filter{ !$0.hasPrefix("fold") }
					.map{ Coordinate(array: $0.split(separator: ",").map{Int($0)!}) }
let foldInstructions = fileContent
						.filter{ $0.hasPrefix("fold") }
						.map{ Instruction(array: $0.split(separator: " ").last!.split(separator: "=").map{ String($0) }) }

print("Nombre de points avant fold : \(coordinates.count)")
fold(coordinates: &coordinates, instructions: foldInstructions)
print("Nombre de points après fold (première instruction uniquement) : \(coordinates.count)")