import java.io.File

data class CaveConnection(val firstCave: String, val secondCave: String)

fun getMap(filename: String): MutableList<CaveConnection> {
	val map = mutableListOf<CaveConnection>()
	File(filename).forEachLine { line -> 
		val split = line.split("-")
		if(split.contains("start")) {
			val cave = if (split[0] == "start") split[1] else split[0]
			map.add(CaveConnection("start", cave))	
		} else if(split.contains("end")) {
			val cave = if (split[0] == "end") split[1] else split[0]
			map.add(CaveConnection(cave, "end"))	
		} else {
			map.add(CaveConnection(split[0], split[1]))
			map.add(CaveConnection(split[1], split[0]))
		}
	}
	return map	
}

fun isCaveBig(cave: String): Boolean {
	for(character in cave) {
		if(!character.isUpperCase()) {
			return false
		}
	}
	return true
}

fun determineAllPaths(map: MutableList<CaveConnection>): MutableList<MutableList<String>> {
	val paths = mutableListOf<MutableList<String>>()
	for(caveConnection in map) {
		if(caveConnection.firstCave == "start") {
			determinePath(paths, mutableListOf("start", caveConnection.secondCave), map)
		}
	}
	return paths
}

fun determinePath(paths: MutableList<MutableList<String>>, path: MutableList<String>, map: MutableList<CaveConnection>) {
	for(caveConnection in map) {
		if(caveConnection.firstCave == path.last()) {
			if(caveConnection.secondCave == "end") {
				val copyPath = path.toMutableList()
				copyPath.add("end")
				paths.add(copyPath)
			} else if((!isCaveBig(caveConnection.secondCave) && !path.contains(caveConnection.secondCave)) || isCaveBig(caveConnection.secondCave)) {
				val copyPath = path.toMutableList()
				copyPath.add(caveConnection.secondCave)
				determinePath(paths, copyPath, map)
			}
		}
	}	
} 

fun main() {
	println("Nombre de chemins trouvés = " + determineAllPaths(getMap("input.txt")).size)
}