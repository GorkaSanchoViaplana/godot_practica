#extends "res://scripts/enemic.gd"
class_name dimoni extends enemic
#El foc es fa a la escena
@export var foc: PackedScene

# var jug: Node2D
#Literalment es la velocitat del atac
var velAtac: float = 400.0




func disparar(jug: CharacterBody2D):
	#Jug es jugador, ho fem per a evitar possibles problemes
	if jug == null:
		return
	else:
		var atac = foc.instantiate()
		var direccio = (jug.global_position - global_position).normalized()
		atac.global_position = global_position
		atac.linear_velocity = direccio * velAtac 
		atac.rotation = direccio.angle() + 135 # així va bé cap al personatge
		get_tree().current_scene.add_child(atac)
