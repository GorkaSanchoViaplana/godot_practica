extends projectil

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not player:
		if body is enemic and body.has_method("morir"):
			body.morir()

func _on_dist_atac_timeout() -> void:
	queue_free()
