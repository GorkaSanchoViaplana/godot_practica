extends RigidBody2D
@onready var sprites = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprites.play("idle")
	$areaAtac.monitoring = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player and body.has_method("morir"):
		body.morir()



func _on_atac_timeout() -> void:
	sprites.play("atac")
	$areaAtac.monitoring = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprites.animation == "atac":
		sprites.play("idle")
		$atac.start()


func _on_area_atac_body_entered(body: Node2D) -> void:
	if body is player and body.has_method("morir") and $areaAtac.monitoring:
		body.morir()
