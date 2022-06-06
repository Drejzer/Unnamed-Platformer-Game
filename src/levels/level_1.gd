extends Node2D


onready var nav = $Navigation2D
onready var bpath=preload("res://src/Player/Bullet/Bullet.tscn")

func _on_Player_Projectile_Fired(pos, dir,mask,damage) -> void:
	var nbull=bpath.instance()
	nbull.position=pos
	nbull.direction=dir
	nbull.damage=damage
	nbull.collision_mask=mask
	add_child(nbull)
