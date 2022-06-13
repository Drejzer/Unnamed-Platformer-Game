extends Control

func _ready():
	$VBoxContainer/StartGameButton.grab_focus()

func _on_StartGameButton_pressed():
	get_tree().change_scene("res://src/levels/level_1.tscn") #Mapka Macieja do wstawienia tutaj


func _on_ExitGameButton_pressed():
	get_tree().quit()
