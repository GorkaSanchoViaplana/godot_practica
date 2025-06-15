extends projectil

func _on_area_2d_body_entered(body: Node2D) -> void:
	#igual que el metode de projectil pero cambiem player per enemic
	if body is not player:
		if body is enemic and body.has_method("morir"):
			body.morir()
		queue_free()

func _on_dist_atac_timeout() -> void:
	queue_free()
