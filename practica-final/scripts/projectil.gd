class_name projectil extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not enemic:
		if body.has_method("morir"): #Aixo sera player 
			body.morir()
		queue_free() #Aixo per a que es destrueixi al tocar algo. Ho fem dins del primer if ja que sino
		#es destruiria nomes ser creat ja que es xocaria amb qui ho tira

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func destruir()->void:
	queue_free()
