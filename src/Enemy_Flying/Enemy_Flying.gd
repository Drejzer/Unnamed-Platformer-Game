extends KinematicBody2D
const SPEED = 50


var velocity = Vector2()
var direction = 1

func _ready():
	$Timer.start()

func _physics_process(delta):
	velocity.x = SPEED * direction
	$AnimationPlayer.play("Fly")
	velocity = move_and_slide(velocity)
	
	if $Timer.time_left == 0:
		direction *= -1
		$Sprite.flip_h = !$Sprite.flip_h 
		$Timer.start()	

func _on_getting_hit():
	$Sprite.visible = false
	$Smoke.visible = true
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
	
