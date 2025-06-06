extends Node2D
@onready var path_follow_1 : PathFollow2D = $Path2D/PathFollow2D
@onready var dimoni_1 = $Path2D/PathFollow2D/dimoni
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow_1.progress += dimoni_1.velocitat * delta

func _on_atac_timeout() -> void:
	dimoni_1.disparar($player)
