use std::fs::File;
use std::io::{self, prelude::*, BufReader};

fn main() -> io::Result<()> {
	// Récupération des valeurs depuis l'input
	let file = File::open("input.txt")?;
	let lines: Vec<_> = BufReader::new(file).lines().collect::<Result<_, _>>().unwrap();
	let crab_positions: Vec<i32> = lines.first().unwrap().split(",").map(|x| x.parse::<i32>().unwrap()).collect();
	
	// La valeur moyenne est la position pour laquelle la consommation est minimale
	let sum: i32 = crab_positions.iter().sum();
	let medium: i32 = sum/crab_positions.len() as i32;
	
	// Calcul de la consommation nécessaire
	let mut needed_fuel: i32 = 0;
	for crab_position in &crab_positions {
		needed_fuel += (1..=(crab_position-medium).abs()).fold(0, |a, b| a + b);
	}
	
	println!("Consommation minimale possible = {}", needed_fuel);

	Ok(())
}