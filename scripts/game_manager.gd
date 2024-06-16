extends Node
class_name GameManager

signal level_done

var player_highest_score: int = 0

func _ready():
	
	#update_hud()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print_debug("Game Manager Ready")
	

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func _on_game_won():
	pass # Replace with function body.
