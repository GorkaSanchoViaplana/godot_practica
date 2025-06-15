extends Control
var nivell = load("res://escenas/level_1.tscn")

func _ready() -> void:
	VaraiablesGlobals.vides = 3

#Script molt simple

func _on_boto_sortir_pressed() -> void:
	get_tree().quit()


func _on_boto_opcions_pressed() -> void:
	pass # Replace with function body.


func _on_boto_jugar_pressed() -> void:
	get_tree().change_scene_to_packed(nivell)
