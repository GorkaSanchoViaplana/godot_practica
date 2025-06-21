extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Aqui preparem la meta 
	var t = load("res://assets/05 - Instruments/harp.png")
	$Meta.nivell = 3
	$Meta.setTexture(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Aixo es dona si el jugador cau del mapa
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		body.morir()
