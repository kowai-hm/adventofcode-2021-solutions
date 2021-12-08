use std::fs::File;
use std::io::{self, prelude::*, BufReader};

fn main() -> io::Result<()> {
	// Récupération des valeurs depuis l'input
	let file = File::open("input.txt")?;
	let lines: Vec<_> = BufReader::new(file).lines().collect::<Result<_, _>>().unwrap();
	let mut crab_positions: Vec<i32> = lines.first().unwrap().split(",").map(|x| x.parse::<i32>().unwrap()).collect();

	// La valeur médiane est la position pour laquelle la consommation est minimale
	crab_positions.sort();
	let median = crab_positions[crab_positions.len()/2];

	// Calcul de la consommation nécessaire
	let mut needed_fuel: i32 = 0;
	for crab_position in &crab_positions {
		needed_fuel += (crab_position-median).abs();
	}

	println!("Consommation minimale possible = {}", needed_fuel);

	Ok(())
}