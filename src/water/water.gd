extends Area2D

func _on_water_body_entered(body):
	var layer = body.get_collision_layer()
	if layer == 2:
		get_tree().reload_current_scene()

