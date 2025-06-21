extends Control
var menuPrincipal = load("res://escenas/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
#Metode simple que et porta al menu
func _on_boto_menu_pressed() -> void:
	get_tree().change_scene_to_packed(menuPrincipal)

#Per a sortir del joc
func _on_boto_sortir_pressed() -> void:
	get_tree().quit()
