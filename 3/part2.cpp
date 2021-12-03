#include <iostream>
#include <fstream>
#include <bitset>
#include <vector>
#include <array>

int main() 
{
	const int bits = 12; // tout du moins, mon input.txt ne contient que des nombres de 12 bits
	
	// Récupération & sauvegarde des inputs depuis le fichier
	std::vector<std::bitset<bits>> reports;
	std::ifstream input("input.txt");
	std::string line;
	while(input >> line) 
	{
		reports.push_back(std::bitset<bits>(line));
	}
	
	// Détermination du oxygen_generator_rating
	std::bitset<bits> oxygen_generator_rating;

	std::vector<std::bitset<bits>> most_common(reports); // copie pour éviter d'altérer l'input originel
	for(int i = bits-1; most_common.size() > 1 && i >= 0; i--)
	{
		std::array<std::vector<std::bitset<bits>>,2> filtered;
		for(auto report : most_common)
		{
			filtered[report[i]].push_back(report);
		}
		most_common = filtered[0].size() > filtered[1].size() ? filtered[0] : filtered[1]; // si égalité, 1 est gardé
	}
	oxygen_generator_rating = most_common.at(0);
	
	// Détermination du co2_scrubber_rating
	std::bitset<bits> co2_scrubber_rating;

	std::vector<std::bitset<bits>> least_common(reports); // copie pour éviter d'altérer l'input originel
	for(int i = bits-1; least_common.size() > 1 && i >= 0; i--)
	{
		std::array<std::vector<std::bitset<bits>>,2> filtered;
		for(auto report : least_common)
		{
			filtered[report[i]].push_back(report);
		}
		least_common = filtered[0].size() > filtered[1].size() ? filtered[1] : filtered[0]; //si égalité, 0 est gardé
	}
	co2_scrubber_rating = least_common.at(0);
	
	std::cout << "Note du générateur d'oxygène : " << oxygen_generator_rating.to_ulong() << std::endl;
	std::cout << "Note de l'épurateur de dioxyde de carbone : " << co2_scrubber_rating.to_ulong() << std::endl;
	std::cout << "Note de l'équipement de survie : " << oxygen_generator_rating.to_ulong()*co2_scrubber_rating.to_ulong() << std::endl;
}