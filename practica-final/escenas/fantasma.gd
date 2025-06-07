extends enemic
@export var velocitat = 300

func _physics_process(delta: float) -> void:
	var moviment = direccio * velocitat * delta
	move_and_slide()
