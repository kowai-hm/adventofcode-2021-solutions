/**
  * Fonction pour vérifier si une chaîne contient tous les caractères d'une sous-chaîne (sans tenir compte de l'ordre).
  */
function containsSubstring(string, substring) {
	return substring.toLowerCase().split('').every(function(letter) {
		return string.toLowerCase().indexOf(letter) != -1;
	});
}

// Récupération de l'input
const lines = require("fs").readFileSync("input.txt", { encoding: "utf-8" }).split(/\r?\n/);
// Détermination de la somme des valeurs de sortie
let output_values_sum = 0;
for(let i = 0; i < lines.length; i++) {
	lines[i] = lines[i].split(" | "); // patterns de signal | valeurs de sortie
	// Patterns de signal (ordonnés), la structure des patterns ordonnés est toujours identique)
	signal_patterns = lines[i][0].split(" ").sort((a,b) => a.length - b.length);
	let segments = [];
	// Traitement des valeurs à nb de segments uniques
	segments[1] = signal_patterns[0]; // chiffre 1 => nombre de segments 2
	segments[4] = signal_patterns[2]; // chiffre 4 => nombre de segments 4
	segments[7] = signal_patterns[1]; // chiffre 7 => nombre de segments 3
	segments[8] = signal_patterns[9]; // chiffre 8 => nombre de segments 7
	// Traitement des autres valeurs
	// Parmi les valeurs à nombre de segments = 5, le chiffre 3 est le seul à contenir les segments du chiffre 1
	segments[3] = signal_patterns.slice(3,6).find(function(signal_pattern) {
		return containsSubstring(signal_pattern, segments[1]);
	});
	// Parmi les valeurs à nombre de segments = 6, le chiffre 6 est le seul à ne pas contenir les segments du chiffre 1
	segments[6] = signal_patterns.slice(6,9).find(function(signal_pattern) {
		return !containsSubstring(signal_pattern, segments[1]);
	});
	// Parmi les valeurs à nombre de segments = 6, le chiffre 9 est le seul à contenir les segments du chiffre 3
	segments[9] = signal_patterns.slice(6,9).find(function(signal_pattern) {
		return containsSubstring(signal_pattern, segments[3]);
	});
	// Parmi les valeurs à nombre de segments = 5, le chiffre 6 est le seul à contenir les segments du chiffre 5
	segments[5] = signal_patterns.slice(3,6).find(function(signal_pattern) {
		return containsSubstring(segments[6], signal_pattern);
	});
	// Parmi les valeurs restantes, le chiffre 8 est le seul à contenir les segments du chiffre 0 
	segments[0] = signal_patterns.slice(6,9).find(function(signal_pattern) {
		return containsSubstring(segments[8], signal_pattern) && !segments.includes(signal_pattern);
	});
	// Les segments du chiffre 2 sont simplement ceux qui ne sont pas encore déterminés
	segments[2] = signal_patterns.slice(3,6).find(function(signal_pattern) {
		return !segments.includes(signal_pattern);
	});
	// Décodage des valeurs de sortie 
	output_values = lines[i][1].split(" ");
	let decoded = "";
	for(let output_value of output_values) {
		decoded += segments.indexOf(segments.find(function(signal_pattern) {
			return containsSubstring(signal_pattern, output_value) && signal_pattern.length == output_value.length;
		})).toString();
	}
	output_values_sum += parseInt(decoded, 10);
}

console.log(`Nombre de chiffres à nombre de segments unique = ${output_values_sum}`);