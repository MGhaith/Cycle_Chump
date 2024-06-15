extends Node

var player_score: int

func _ready():
	print_debug("Game Manager Ready")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func change_score(value : int):
	player_score += value
