extends CanvasLayer
@onready var vides := $Control/vidasLabel


func _process(delta: float) -> void:
	vides.text = "X %d" % VaraiablesGlobals.vides
