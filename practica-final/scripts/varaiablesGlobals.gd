extends Node

var vides := 3
var pantallaPerdre = load("res://escenas/menu_perdre.tscn")

func restarVida()->void:
	vides -= 1
	if vides <=0:
		get_tree().change_scene_to_packed(pantallaPerdre)
