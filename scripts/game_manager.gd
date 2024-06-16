extends Node
class_name GameManager

signal level_done

var player_highest_score: int = 0

func _ready():
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print_debug("Game Manager Ready")
	

#func _process(_delta):
	#

func quit_game():
	get_tree().quit()

func _on_game_won():
	pass # Replace with function body.
