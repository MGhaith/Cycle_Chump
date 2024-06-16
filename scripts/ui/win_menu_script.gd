extends Control
 

func _on_play_again_button_down():
	self.get_parent().get_parent()._on_game_won()
