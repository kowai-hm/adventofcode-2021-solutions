last_measurement = -50000  # valeur arbitraire (les mesures ont l'air d'être toutes positives)
larger_than_previous = -1  # la première valeur sera forcément plus haute

with open("input.txt") as input:
    for depth_measurement in input:
        if int(depth_measurement) > last_measurement:
            larger_than_previous += 1
        last_measurement = int(depth_measurement)
            
print(f"Nombre de mesures plus larges que la précédente = {larger_than_previous}")