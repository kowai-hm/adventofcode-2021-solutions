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

func ModelSteps(octopusGrid *[10][10]int) int {
	steps := 1
	for !ModelStep(octopusGrid) {
		steps += 1
	}
	return steps
}

func ModelStep(octopusGrid *[10][10]int) bool {
	for i := range octopusGrid {
		for j := range octopusGrid[i] {
			octopusGrid[i][j]++
			if octopusGrid[i][j] == 10 {
				Flash(octopusGrid, i, j)
			}
		}
	}
	allFlash := true
	for i := range octopusGrid {
		for j := range octopusGrid[i] {
			if octopusGrid[i][j] >= 10 {
				octopusGrid[i][j] = 0
			} else {
				allFlash = false
			}
		}
	}
	return allFlash
}

func Flash(octopusGrid *[10][10]int, y, x int) {
	for i := y-1; i <= y+1; i++ {
		for j := x-1; j <= x+1; j++ {
			// On vérifie si on est bien dans le tableau
			if i >= 0 && j >= 0 && i < len(octopusGrid) && j < len(octopusGrid[i]) {
				octopusGrid[i][j]++
				if octopusGrid[i][j] == 10 {
					Flash(octopusGrid, i, j)
				}
			}
		}
	}
}

func main() {
	octopusGrid := GetOctopusGrid("input.txt")
	allFlashStep := ModelSteps(&octopusGrid)
	fmt.Printf("Étape lors de laquelle toutes les pieuvres flashent simultanément : %d\n", allFlashStep)
}