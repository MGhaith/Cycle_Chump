extends Node
class_name GameManager

signal level_done

@export var points_node: Node
@export var score_value_ui: Label
@export var highest_score_ui: Label
@export var points_left_ui: Label

var player_score: int = 0
var player_highest_score: int = 0
var points_left: int = 0

func _ready():
	#points_left = len(points_node.get_children()) 
	#
	#if points_node != null:
		#for point in points_node.get_children():
			#point.game_manager = self
	
	#update_hud()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print_debug("Game Manager Ready")
	

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func change_score(value : int):
	player_score += value
	points_left -= 1
	
	if player_score > player_highest_score:
		player_highest_score = player_score
	
	# The level is cleared
	if points_left == 0:
		emit_signal("level_done")
	
	update_hud()

func update_hud():
	
	score_value_ui.text = str(player_score)
	points_left_ui.text = str(points_left)
	highest_score_ui.text = str(player_highest_score)
	


func _on_game_won():
	pass # Replace with function body.
