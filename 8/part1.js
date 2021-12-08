// Nombres de segments uniques
let segments = [2,4,3,7];

// Récupération de l'input
const lines = require("fs").readFileSync("input.txt", { encoding: "utf-8" }).split(/\r?\n/);
// Isolation de l'output value et identification des valeurs à nombre de segments unique
let uniqueValues = 0;
for(let i = 0; i < lines.length; i++) {
	lines[i] = String(lines[i].split(" | ")[1]).split(" ");
	for(let j = 0; j < lines[i].length; j++) {
		if(segments.includes(lines[i][j].length)) {
			uniqueValues++;
		}
	}
}

console.log(`Nombre de chiffres à nombre de segments unique = ${uniqueValues}`);