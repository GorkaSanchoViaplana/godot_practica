extends "res://scripts/enemic.gd"

func _physics_process(delta: float) -> void:
	if not es_viu:
		return
	velocity.x = direccio * SPEED
	move_and_slide()
	sprites.play("caminar")
	# sprites.fip_h = direccio < 0
