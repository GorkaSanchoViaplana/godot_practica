extends "res://scripts/enemic.gd"

@export var foc: PackedScene
@export var velocitat = 100
# var jug: Node2D
var velAtac: float = 400.0


#func _physics_process(delta: float) -> void:
#	if not es_viu:
#		return
	#velocity.x = direccio * SPEED
	#move_and_slide()
#	sprites.play("caminar")

func disparar(jug: CharacterBody2D):
	if jug == null:
		return
	else:
		var atac = foc.instantiate()
		var direccio = (jug.global_position - global_position).normalized()
		atac.global_position = global_position
		atac.linear_velocity = direccio * velAtac 
		atac.rotation = direccio.angle() + 135 # així va bé cap al personatge
		get_tree().current_scene.add_child(atac)
