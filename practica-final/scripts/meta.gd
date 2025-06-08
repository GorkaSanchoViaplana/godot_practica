extends RigidBody2D
# @export var instrument: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$Sprite2D.texture = instrument.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		print("META")
