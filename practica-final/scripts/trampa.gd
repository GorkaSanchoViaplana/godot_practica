extends RigidBody2D
@onready var sprites = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprites.play("idle")
	$areaAtac.monitoring = false

#Activem hitbox i fem la animacio. 
func _on_atac_timeout() -> void:
	sprites.play("atac")
	$areaAtac.monitoring = true

#Si ataquem activem el timer i desactivem el monitoring
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprites.animation == "atac":
		sprites.play("idle")
		$atac.start()
		$areaAtac.monitoring = false


func _on_area_atac_body_entered(body: Node2D) -> void:
	#Important el monitoring del if per a evitar que sempre mati
	if body is player and body.has_method("morir") and $areaAtac.monitoring:
		body.morir()
