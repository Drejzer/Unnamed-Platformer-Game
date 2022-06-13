extends Area2D

func _on_flag_body_entered(body):
	var layer = body.get_collision_layer()

	if layer == 2:
		PlayerData.level+=1
		PlayerData.CoinsCollected=0
		if(PlayerData.level < 4):
			get_tree().change_scene("res://src/levels/level_" + str(PlayerData.level) + ".tscn")
		else:
			get_tree().change_scene("res://src/GUI/Menu.tscn")
