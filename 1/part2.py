larger_than_previous = 0

with open("input.txt") as input:
    depth_measurements = [int(depth_measurement.rstrip()) for depth_measurement in input]

sliding_window = depth_measurements[0:3]  # Première fenêtre coulissante
prev_sw_sum = sum(sliding_window) # Somme de la fenêtre précédente
for depth_measurement in depth_measurements[3:]:
    # Retire l'élément le plus ancien et ajoute le nouveau
    sliding_window.pop(0)
    sliding_window.append(depth_measurement)
    # Compare
    actual_sw_sum = sum(sliding_window)
    if actual_sw_sum > prev_sw_sum:
        larger_than_previous += 1
    # Pour éviter de faire deux sommes par fenêtre coulissante
    prev_sw_sum = actual_sw_sum
        
print(f"Nombre de sommes de fenêtres coulissantes plus larges que la précédente = {larger_than_previous}")