#include <iostream>
#include <fstream>
#include <bitset>
#include <vector>

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
	
	// Détermination du gamma_rate et de l'epsilon_rate
	std::bitset<bits> gamma_rate, epsilon_rate;
	for(int i = bits-1; i >= 0; i--)
	{
		int counts[2] {0,0};
		for(auto report : reports)
		{
			counts[report[i]]++;
		}
		gamma_rate[i] = counts[0] > counts[1] ? 0 : 1;
	}
	epsilon_rate = std::bitset<bits>(gamma_rate).flip();
	
	std::cout << "Taux gamma : " << gamma_rate.to_ulong() << std::endl;
	std::cout << "Taux epsilon : " << epsilon_rate.to_ulong() << std::endl;
	std::cout << "Consommation électrique : " << gamma_rate.to_ulong()*epsilon_rate.to_ulong() << std::endl;
}