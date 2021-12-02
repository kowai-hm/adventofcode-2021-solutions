package aoc2021.day2;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Part2 {
	
	public static void main(String[] args) {
		int horizontalPosition = 0;
		int depth = 0;
		int aim = 0;
		
		try {
			Scanner scanner = new Scanner(new File("input.txt"));
			while (scanner.hasNextLine()) {
				String instruction = scanner.nextLine();
				String[] tokens = instruction.split(" "); // instruction valeur
				int value = Integer.parseInt(tokens[1]);
				switch(tokens[0]) {
					case "forward":
						horizontalPosition += value;
						depth += aim*value;
						break;
					case "down":
						aim += value;
						break;
					default: // up
						aim -= value;
				}
			}
			scanner.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		System.out.println("Position horizontale finale : " + horizontalPosition);
		System.out.println("Niveau de profondeur final : " + depth);
		System.out.println("Multiplication des deux : " + horizontalPosition*depth);
	}
	
}