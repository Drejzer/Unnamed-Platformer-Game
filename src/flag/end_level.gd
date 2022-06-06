extends Area2D

func _on_flag_body_entered(body):
	var layer = body.get_collision_layer()
	if layer == 2:
		get_tree().change_scene("res://src/levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
