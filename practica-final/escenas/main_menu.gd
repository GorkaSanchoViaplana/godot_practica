extends Control
var nivell = load("res://escenas/level_1.tscn")

#Amb aixo cada cop que reiniciem el joc reniciem vides
func _ready() -> void:
	VaraiablesGlobals.vides = 3

#Script molt simple
func _on_boto_sortir_pressed() -> void:
	get_tree().quit()

#Metode molt simple que carrega el nivell
func _on_boto_jugar_pressed() -> void:
	get_tree().change_scene_to_packed(nivell)
