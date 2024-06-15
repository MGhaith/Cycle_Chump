extends Node
class_name GameManager

@export var points_node: Node

var player_score: int

func _ready():
	for point in points_node.get_children():
		point.game_manager = self
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print_debug("Game Manager Ready")
	

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func change_score(value : int):
	player_score += value
	print(str(player_score))
