extends Node3D

@export var score_value_ui: Label
@export var highest_score_ui: Label
@export var points_left_ui: Label
@export var points_node: Node
@export var sound_manager: Node

var points_left: int = 0
var player_score: int = 0
var game_manager: GameManager

func _ready():
	points_left = len(points_node.get_children()) 

func change_score(value : int):
	player_score += value
	points_left -= 1
	
	sound_manager.play_point_pick()
	
	if game_manager != null:
		if player_score > game_manager.player_highest_score:
			game_manager.player_highest_score = player_score
	
	# The level is cleared
	if points_left == 0:
		emit_signal("level_done")
	
	update_hud()

func update_hud():
	
	score_value_ui.text = str(player_score)
	points_left_ui.text = str(points_left)
	#highest_score_ui.text = str(game_manager.player_highest_score)
