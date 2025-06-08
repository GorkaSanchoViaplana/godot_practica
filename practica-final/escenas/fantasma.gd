extends enemic

func _ready() -> void:
	velocitat = 300

func _physics_process(delta: float) -> void:
	var moviment = direccio * velocitat * delta
	move_and_slide()
