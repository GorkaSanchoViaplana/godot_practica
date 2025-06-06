class_name enemic extends CharacterBody2D
@onready var sprites = $AnimatedSprite2D

const SPEED = 150.0
var direccio := -1 
var es_viu := true 
var vida := 3
func _physics_process(delta: float) -> void:
	if not es_viu:
		return
	velocity.x = direccio * SPEED
	move_and_slide()
	sprites.play("caminar")
	sprites.flip_h = direccio < 0
	

func morir():
	es_viu = false;
	sprites.play("morir")
	await sprites.animation_finished
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
