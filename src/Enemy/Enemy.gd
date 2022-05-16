extends KinematicBody2D
const GRAVITY = 10
const SPEED = 50
const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var direction = 1
var layer = null

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction
	$AnimationPlayer.play("Walk Right")
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity,FLOOR)
	
	if is_on_wall():
		direction *= -1
		$Sprite.flip_h = !$Sprite.flip_h 
		$RayCast2D.position.x *= -1
	
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$Sprite.flip_h = !$Sprite.flip_h 
		$RayCast2D.position.x *= -1

func onGettingHit():
	queue_free()
