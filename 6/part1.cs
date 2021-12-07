using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
	
class Part1
{
	
	static void Simulate(List<int> lanternfish_timers, int days) 
	{
		for(int i = 0; i < days; i++) 
		{
			for(int j = 0; j < lanternfish_timers.Count; j++)
			{
				lanternfish_timers[j]--;
				if(lanternfish_timers[j] < 0)
				{
					lanternfish_timers[j] = 6;
					lanternfish_timers.Add(9); // normalement 8 mais pour prendre en compte la future décrémentation
				}
			}
		}
	}
	
	static void Main(string[] args)
	{
		List<int> lanternfish_timers = Array.ConvertAll(File.ReadLines("input.txt").First().Split(','), token => int.Parse(token)).ToList();
		Simulate(lanternfish_timers, 80);
		Console.WriteLine("Nombre de poissons-lanternes = " + lanternfish_timers.Count);
	}

}