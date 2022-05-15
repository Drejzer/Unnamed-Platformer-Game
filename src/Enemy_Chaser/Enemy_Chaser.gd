extends KinematicBody2D
const SPEED = 30
var velocity = Vector2()
var layer = null
var enemy = null

var path = []
var nav = null
var direction = null

func _ready():
	yield(owner,"ready")
	nav = owner.nav
	$AnimationPlayer.play("Flying")
	
func _physics_process(delta):
	if enemy != null:
		get_target_path(enemy.global_position)
		navigate()
		velocity = move_and_slide(velocity)

func get_target_path(target_pos):
	path = nav.get_simple_path(self.global_position,target_pos,false)
	
func navigate(): #Funkcja generująca wektor pozwalający na ruch w stronę gracza		
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
	if global_position == path[0]:
		path.remove(0)

func _on_VisionArea_body_entered(body):
	layer = body.get_collision_layer()
	if layer == 2:
		enemy = body
		
func _on_VisionArea_body_exited(body):
	layer = body.get_collision_layer()
	if layer == 2:
		enemy = null


		
	
		
		
		
		
		
