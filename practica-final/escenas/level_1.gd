extends Node2D
@onready var path_follow_1 : PathFollow2D = $Path2D/PathFollow2D
@onready var path_follow_2 : PathFollow2D = $Path2D2/PathFollow2D
@onready var dimoni_1 = $Path2D/PathFollow2D/dimoni
@onready var fantasma_1 = $Path2D2/PathFollow2D/fantasma
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(dimoni_1):
		path_follow_1.progress += dimoni_1.velocitat * delta
		
	if is_instance_valid(fantasma_1):
		path_follow_2.progress += fantasma_1.velocitat * delta

func _on_atac_timeout() -> void:
	dimoni_1.disparar($player)
