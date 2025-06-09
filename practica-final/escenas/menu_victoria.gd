extends Control

var menuPrincipal = load("res://escenas/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boto_tornar_jugar_pressed() -> void:
	get_tree().change_scene_to_packed(menuPrincipal)


func _on_boto_sortir_pressed() -> void:
	get_tree().quit()
