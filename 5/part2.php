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
	
	$x_equals = $first_end->x == $second_end->x;
	$x_increment = $first_end->x < $second_end->x;
	$y_equals = $first_end->y == $second_end->y;
	$y_increment = $first_end->y < $second_end->y;

	$temp = $line_segment[0];
	$crossed = false;
	while(!$crossed) {
		$y = $temp->y;
		$x = $temp->x;
		$diagram[$y][$x] = isset($diagram[$y][$x]) ? $diagram[$y][$x]+1 : 1;
		if($temp == $second_end) {
			$crossed = true;
		}
		if(!$x_equals) {
			$temp->x = $x_increment ? $temp->x+1 : $temp->x-1;
		}
		if(!$y_equals) {
			$temp->y = $y_increment ? $temp->y+1 : $temp->y-1;
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