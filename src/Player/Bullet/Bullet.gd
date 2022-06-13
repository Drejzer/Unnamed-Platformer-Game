extends Area2D


var direction:Vector2 setget dirset

func dirset(val:Vector2):
	if val.x<0:
		$Sprite.scale.x=-1
	elif val.x>0:
		$Sprite.scale.x=1
	direction=val
	
var damage:=1

func _ready() -> void:
	collision_layer=4

func _physics_process(delta: float) -> void:
	position.x=lerp(position.x,position.x+direction.x,delta)
	position.y=lerp(position.y,position.y+direction.y,delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Bullet_body_entered(body: Node) -> void:
	if body.has_method("_on_getting_hit"):
		body._on_getting_hit()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
