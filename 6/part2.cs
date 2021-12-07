using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
	
class Part2
{
	
	static long Simulate(int[] lanternfishTimers, int days) 
	{
		long[] timerCounts = new long[9];
		foreach(int timer in lanternfishTimers)
		{
			timerCounts[timer]++;
		}
		for(int i = 0; i < days; i++)
		{
			long aboutToSpawn = timerCounts[0];
			for(int j = 0; j < timerCounts.Length-1; j++)
			{
				timerCounts[j] = timerCounts[j+1];
			}
			timerCounts[timerCounts.Length-1] = aboutToSpawn;
			timerCounts[6] += aboutToSpawn;
		}
		return timerCounts.Sum(timerCount => (long) timerCount);
	}
	
	static void Main(string[] args)
	{
		int[] lanternfishTimers = Array.ConvertAll(File.ReadLines("input.txt").First().Split(','), token => int.Parse(token));
		Console.WriteLine("Nombre de poissons-lanternes = " + Simulate(lanternfishTimers, 256));
	}

}