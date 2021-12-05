<?php

// Définition d'une paire de coordonnées
class Point {
    public int $x;
    public int $y;

    public function __construct(int $x, int $y) {
        $this->x = $x;
        $this->y = $y;
    }
}

// Récupération des paires de coordonnées
$line_segments = array();

$input = fopen("input.txt", "r");
while (($line = fgets($input)) !== false) {
	list($first_end, $second_end) = explode(" -> ", $line);
	$first_end = explode(",", $first_end);
	$second_end = explode(",", $second_end);
	array_walk($first_end, 'intval');
	array_walk($second_end, 'intval');
	array_push($line_segments, [new Point($first_end[0], $first_end[1]), new Point($second_end[0], $second_end[1])]);
}
fclose($input);

// Constitution du diagramme
$diagram = array();

foreach($line_segments as $line_segment) {
	$first_end = $line_segment[0];
	$second_end = $line_segment[1];
	$sameX = $first_end->x == $second_end->x;
	$sameY = $first_end->y == $second_end->y;
	if($sameX || $sameY) {  // on ne prend pas en compte les mouvements diagonaux dans la partie 1
		if($sameX) {
			$x = $first_end->x;
			if($first_end->y > $second_end->y) {
				for($y = $first_end->y; $y >= $second_end->y; $y--) {
					$diagram[$y][$x] = isset($diagram[$y][$x]) ? $diagram[$y][$x]+1 : 1;
				}
			} else {
				for($y = $first_end->y; $y <= $second_end->y; $y++) {
					$diagram[$y][$x] = isset($diagram[$y][$x]) ? $diagram[$y][$x]+1 : 1;
				}
			}
		} else if($sameY) {
			$y = $first_end->y;
			if($first_end->x > $second_end->x) {
				for($x = $first_end->x; $x >= $second_end->x; $x--) {
					$diagram[$y][$x] = isset($diagram[$y][$x]) ? $diagram[$y][$x]+1 : 1;
				}
			} else {
				for($x = $first_end->x; $x <= $second_end->x; $x++) {
					$diagram[$y][$x] = isset($diagram[$y][$x]) ? $diagram[$y][$x]+1 : 1;
				}
			}	
		}
	}
}

// Détermination du nombre de superpositions
$overlaps = 0;
foreach($diagram as $row) {
	foreach($row as $point) {
		if($point > 1) {
			$overlaps++;
		}
	}
}

echo "Nombre de superpositions : " . $overlaps;

?>