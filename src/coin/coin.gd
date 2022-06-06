extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_coin_body_entered(body):
	var layer = body.get_collision_layer()
	if layer == 2:
		body.add_coin()
		$AnimationPlayer.play("bounce")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
