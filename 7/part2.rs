use std::fs::File;
use std::io::{self, prelude::*, BufReader};

fn main() -> io::Result<()> {
	// Récupération des valeurs depuis l'input
    let file = File::open("input.txt")?;
	let lines: Vec<_> = BufReader::new(file).lines().collect::<Result<_, _>>().unwrap();
	let crab_positions: Vec<i32> = lines.first().unwrap().split(",").map(|x| x.parse::<i32>().unwrap()).collect();
	
	// Recherche par bruteforce
	let minimum = *crab_positions.iter().min().unwrap();
	let maximum = *crab_positions.iter().max().unwrap();
	
	let mut cheapest_fuel = i32::MAX;
	for possible_position in minimum..=maximum {
		let mut needed_fuel: i32 = 0;
		for crab_position in &crab_positions {
			needed_fuel += (1..=(crab_position-possible_position).abs()).fold(0, |a, b| a + b);
		}
		if needed_fuel < cheapest_fuel {
			cheapest_fuel = needed_fuel;
		}
	}
	
	println!("Consommation minimale possible = {}", cheapest_fuel);

    Ok(())
}