package aoc2021.day2;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Part1 {
	
	public static void main(String[] args) {
		int horizontalPosition = 0;
		int depth = 0;
		
		Scanner scanner;
		try {
			scanner = new Scanner(new File("input.txt"));
		} catch (FileNotFoundException e) {
			return;
		}
		while (scanner.hasNextLine()) {
			String instruction = scanner.nextLine();
			String[] tokens = instruction.split(" "); // instruction valeur
			int value = Integer.parseInt(tokens[1]);
			switch(tokens[0]) {
				case "forward":
					horizontalPosition += value;
					break;
				case "down":
					depth += value;
					break;
				default: // up
					depth -= value;
			}
		}
		scanner.close();
		
		System.out.println("Position horizontale finale : " + horizontalPosition);
		System.out.println("Niveau de profondeur final : " + depth);
		System.out.println("Multiplication des deux : " + horizontalPosition*depth);
	}
	
}