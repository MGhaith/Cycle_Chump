extends Node3D
@export_category("GUI Nodes")
@export var score_value_ui: Label
@export var highest_score_ui: Label
@export var points_left_ui: Label
@export var points_node: Node
@export var sound_manager: Node
@export var stamina_var : ProgressBar
@export var pause_menu : CanvasLayer
@export var game_over_menu: CanvasLayer

@export_category("Game Nodes")
@export var player : VehicleBody3D

var points_left: int = 0
var game_manager: GameManager

func _ready():
	points_left = len(points_node.get_children()) 
	game_manager = get_tree().current_scene
	update_hud()

func change_score(value : int):
	game_manager.player_score += value
	points_left -= 1
	
	sound_manager.play_point_pick()
	
	if game_manager != null:
		if game_manager.player_score > game_manager.player_highest_score:
			game_manager.player_highest_score = game_manager.player_score
	
	# The level is cleared
	if points_left == 0:
		emit_signal("level_done")
	
	update_hud()

func _input(event):
	if event.is_action_pressed("pause"):
		pause_menu.open_ui()
		get_tree().paused = true

func update_hud():
	stamina_var.value = player.current_stamina
	points_left_ui.text = str(points_left)
	score_value_ui.text = str(game_manager.player_score)
	highest_score_ui.text = str(game_manager.player_highest_score)
	
func on_player_death() -> void:
	$GameOver/Canvas.can_replay = true
	$GameOver/Canvas.set_scores(game_manager.player_score, game_manager.player_highest_score)
	game_over_menu.open_ui()
	sound_manager.stop_bgm()
	player.queue_free()
