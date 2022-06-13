extends Control

func on_player_coins_changed(player_coins) -> void:
	$NumCoins.text = str(player_coins)
	
func _ready():
	pass
