package main

import "bufio"
import "fmt"
import "log"
import "os"

func GetOctopusGrid(filename string) [10][10]int {
	octopusGrid := [10][10]int{}
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	scanner := bufio.NewScanner(file)
	y := 0
	for scanner.Scan() {
		line := scanner.Text()
		for x, c := range line {
			octopusGrid[y][x] = int(c - '0')
		}
		y++
	}
	file.Close()
	return octopusGrid
}

func ModelSteps(octopusGrid *[10][10]int, nbSteps int) int {
	flashes := 0
	for i := 0; i < nbSteps; i++ {
		flashes += ModelStep(octopusGrid)
	}
	return flashes
}

func ModelStep(octopusGrid *[10][10]int) int {
	flashes := 0
	for i := range octopusGrid {
		for j := range octopusGrid[i] {
			octopusGrid[i][j]++
			if octopusGrid[i][j] == 10 {
				flashes += Flash(octopusGrid, i, j)
			}
		}
	}
	for i := range octopusGrid {
		for j := range octopusGrid[i] {
			if octopusGrid[i][j] >= 10 {
				octopusGrid[i][j] = 0
			}
		}
	}
	return flashes
}

func Flash(octopusGrid *[10][10]int, y, x int) int {
	cascadingFlashes := 1
	for i := y-1; i <= y+1; i++ {
		for j := x-1; j <= x+1; j++ {
			// On vérifie si on est bien dans le tableau
			if i >= 0 && j >= 0 && i < len(octopusGrid) && j < len(octopusGrid[i]) {
				octopusGrid[i][j]++
				if octopusGrid[i][j] == 10 {
					cascadingFlashes += Flash(octopusGrid, i, j)
				}
			}
		}
	}
	return cascadingFlashes
}

func main() {
	octopusGrid := GetOctopusGrid("input.txt")
	flashes := ModelSteps(&octopusGrid, 100)
	fmt.Printf("Nombre total de flashs : %d\n", flashes)
}