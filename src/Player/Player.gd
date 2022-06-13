extends KinematicBody2D

export var speed:=100
export var jump_power:=250
export var gravity:=1000

## Position and direction sould be both Vector2
signal Projectile_Fired(pos, dir,mask,damage)
signal Got_Hurt()
signal life_changed(value)
signal update_coins(value)

onready var velocity= Vector2.ZERO
onready var anim_sprite:AnimatedSprite
onready var layer = null
var ishurt:=false

func move_handler(_delta:float):
	velocity.x=0
	velocity.x=Input.get_action_strength("right")*speed-Input.get_action_strength("left")*speed
	if velocity.x!=0:
		anim_sprite.play("walk")
	else:
		anim_sprite.play("idle")
	if velocity.x<0:
		anim_sprite.scale.x=-1
	elif velocity.x>0:
		anim_sprite.scale.x=1

func jump():
	if self.is_on_floor():
		velocity.y=-jump_power

func shoot():
	emit_signal("Projectile_Fired",Vector2(self.position.x+anim_sprite.scale.x*7,self.position.y),Vector2(anim_sprite.scale.x*PlayerData.bullet_speed,0),9,PlayerData.bullet_power)

func _ready() -> void:
	anim_sprite=$AnimatedSprite
	var h = get_node("HUD/Life")
	#h.connect("life_changed", self, "on_player_life_changed()")
	connect("life_changed",get_node("HUD/Life"),"on_player_life_changed")
	connect("update_coins", get_node("HUD/Coins"),"on_player_coins_changed")
	emit_signal("life_changed", PlayerData.MaxHealth)
	emit_signal("update_coins", PlayerData.TotalCoins)
	pass

func on_getting_hit():
	PlayerData.CurrentHealth-=1
	emit_signal("Got_Hurt")
	emit_signal("life_changed", PlayerData.CurrentHealth)
	print(PlayerData.CurrentHealth)
	print(collision_mask)
	collision_mask=collision_mask&0b111111111111111110111
	print(collision_mask)
	ishurt=true
	$ITImer.start(0.77)
	velocity=Vector2(-anim_sprite.scale.x*300,-222)
	
	pass
	

func _physics_process(delta: float) -> void:
	if !ishurt:
		move_handler(delta)
	else:
		velocity.x=lerp(velocity.x,0,delta*5)
	velocity.y+=gravity*delta
	velocity=move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func _on_ITImer_timeout() -> void:
	collision_mask=collision_mask|0b1000
	ishurt=false
	print(collision_mask)
	pass # Replace with function body.

func add_coin():
	PlayerData.CoinsCollected+=1
	PlayerData.TotalCoins+=1
	print("Total Coins collected: ",PlayerData.TotalCoins)
	emit_signal("update_coins",PlayerData.TotalCoins)



func _on_GettingHitArea_body_entered(body):
	layer = body.get_collision_layer()
	if layer == 8:
		on_getting_hit()
