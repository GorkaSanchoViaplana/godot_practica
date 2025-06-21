extends RigidBody2D
@onready var instrument = $Sprite2D
var victoria = load("res://escenas/menu_victoria.tscn")
var nivell
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$Sprite2D.texture = instrument.texture

#Aixo es perque les diferents textures les carreguem al nivell
func setTexture(t) -> void:
	instrument.texture = t

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player: # aquesta solució ens serveix perquè només són tres nivells
		VaraiablesGlobals.sumarVida()
		if nivell == 1:
			get_tree().change_scene_to_file("res://escenas/level_2.tscn")
		elif nivell == 2:
			get_tree().change_scene_to_file("res://escenas/level_3.tscn")
		else:
			get_tree().change_scene_to_packed(victoria)
