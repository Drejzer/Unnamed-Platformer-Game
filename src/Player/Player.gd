extends KinematicBody2D

export var speed:=300
export var jump_power:=500
export var gravity:=1000
## Position and direction sould be both Vector2
signal Projectile_Fired(position, direction)

onready var velocity= Vector2.ZERO
onready var anim_sprite:AnimatedSprite

func move_handler():
	velocity.x=0
	velocity.x=Input.get_action_strength("right")*speed-Input.get_action_strength("left")*speed
	if velocity.x!=0:
		anim_sprite.play("walk")
	else:
		anim_sprite.play("idle")
	if velocity.x<0:
		self.scale.x=-1
	elif velocity.x>0:
		self.scale.x=1

func jump():
	if self.is_on_floor():
		velocity.y=-jump_power

func shoot():
	emit_signal("Projectile_Fired",self.position,Vector2(self.scale.x*10,0))
	print("pew")

func _ready() -> void:
	anim_sprite=$AnimatedSprite
	pass

func _physics_process(delta: float) -> void:
	move_handler()
	velocity.y+=gravity*delta
	velocity=move_and_slide(velocity)
	if Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_pressed("shoot"):
		shoot()
