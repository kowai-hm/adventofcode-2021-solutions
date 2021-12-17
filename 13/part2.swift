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
	for instruction in instructions {
		for i in coordinates.indices {
			if(instruction.foldAxis == "y" && coordinates[i].y > instruction.coordinate) { // pli horizontal
				coordinates[i].y = instruction.coordinate*2 - coordinates[i].y
			} else if(instruction.foldAxis == "x" && coordinates[i].x > instruction.coordinate) { // pli vertical
				coordinates[i].x = instruction.coordinate*2 - coordinates[i].x
			}
		}
	}
	coordinates = Array(Set(coordinates))
}

func displayPaper(coordinates: Array<Coordinate>) {
	let lowestX = coordinates.min(by: { (a,b) -> Bool in
		return a.x < b.x
	})!.x
	let maxX = coordinates.max(by: { (a,b) -> Bool in
		return a.x < b.x
	})!.x
	let lowestY = coordinates.min(by: { (a,b) -> Bool in
		return a.y < b.y
	})!.y
	let maxY = coordinates.max(by: { (a,b) -> Bool in
		return a.y < b.y
	})!.y
	for y in lowestY...maxY {
		for x in lowestX...maxX {
			if(coordinates.filter { $0.x == x && $0.y == y }.count == 1) {
				print("#", terminator: "")
			} else {
				print(" ", terminator: "")
			}
		}
		print("")
	}
}

let fileContent = getFileContent(filename: "input.txt")

var coordinates = fileContent
					.filter{ !$0.hasPrefix("fold") }
					.map{ Coordinate(array: $0.split(separator: ",").map{Int($0)!}) }
let foldInstructions = fileContent
						.filter{ $0.hasPrefix("fold") }
						.map{ Instruction(array: $0.split(separator: " ").last!.split(separator: "=").map{ String($0) }) }

fold(coordinates: &coordinates, instructions: foldInstructions)
displayPaper(coordinates: coordinates)