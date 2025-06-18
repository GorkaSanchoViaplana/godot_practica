extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t = load("res://assets/05 - Instruments/harp.png")
	$Meta.nivell = 3
	$Meta.setTexture(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
