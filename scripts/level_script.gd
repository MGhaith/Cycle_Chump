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
var player_score: int = 0
var game_manager: GameManager
var pause_game = false

func _ready():
	points_left = len(points_node.get_children()) 
	update_hud()
	await get_tree().create_timer(1).timeout
	pause_game = true

func _input(event):
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_menu.open_ui()
		sound_manager.pause_bgm()
		get_tree().paused = true

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
	stamina_var.value = player.current_stamina
	score_value_ui.text = str(player_score)
	points_left_ui.text = str(points_left)
	#highest_score_ui.text = str(game_manager.player_highest_score)
	
func on_player_death() -> void:
	game_over_menu.open_ui()
	sound_manager.stop_bgm()
	player.queue_free()
