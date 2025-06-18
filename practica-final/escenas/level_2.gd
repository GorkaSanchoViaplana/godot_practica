extends Node2D
@onready var path_follow_1 : PathFollow2D = $Path2D/PathFollow2D
@onready var path_follow_2 : PathFollow2D = $Path2D2/PathFollow2D
@onready var path_follow_3 : PathFollow2D = $Path2D3/PathFollow2D
@onready var dimoni_1 = $Path2D/PathFollow2D/enemic
@onready var dimoni_2 = $Path2D2/PathFollow2D/enemic
@onready var fantasma_1 = $Path2D3/PathFollow2D/Fantasma
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t = load("res://assets/05 - Instruments/trumpet.png")
	$Meta.nivell = 2
	$Meta.setTexture(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Tots aquests if son per a evitar intentar moure enemics morts, cosa que crashea el joc
	if is_instance_valid(dimoni_1):
		path_follow_1.progress += dimoni_1.velocitat * delta
	if is_instance_valid(dimoni_2):
		path_follow_2.progress += dimoni_2.velocitat * delta
	if is_instance_valid(fantasma_1):
		path_follow_3.progress += fantasma_1.velocitat * delta

#Ho fem aqui ja que aixi en cada nivell podem modificar els atacs del enemic

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		body.morir()

func _on_atac_timeout() -> void:
	dimoni_1.disparar($player)

func _on_atac_2_timeout() -> void:
	dimoni_2.disparar($player)
