extends Node

signal PlayerDied
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var MaxHealth:=3
var CurrentHealth:=3 setget CurrentHealth_set, CurrentHealth_get

func CurrentHealth_set(nch:int):
	CurrentHealth=int(clamp(nch,0,MaxHealth))
	if CurrentHealth==0:
		emit_signal("PlayerDied")

func CurrentHealth_get()->int:
	return CurrentHealth
