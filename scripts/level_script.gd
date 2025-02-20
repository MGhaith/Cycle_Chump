extends Node3D

signal enable_exits

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
@export var exit1 : Node
@export var exit2 : Node

var ramdon_finish = 0
var points_left: int = 0
var game_manager: GameManager
var pause_game = false
var is_game_over: bool = false

func _ready():
	points_left = len(points_node.get_children()) 
	game_manager = get_tree().current_scene
	update_hud()
	await get_tree().create_timer(1).timeout
	pause_game = true

func _input(event):
	if event.is_action_pressed("escape") and !is_game_over:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_menu.open_ui()
		get_tree().paused = true

func change_score(value : int):
	game_manager.player_score += value
	points_left -= 1
	
	sound_manager.play_point_pick()
	
	if game_manager != null:
		if game_manager.player_score > game_manager.player_highest_score:
			game_manager.player_highest_score = game_manager.player_score
	
	# The level is cleared
	if points_left == 0:
		emit_signal("enable_exits")
	
	update_hud()

func update_hud():
	points_left_ui.text = str(points_left)
	score_value_ui.text = str(game_manager.player_score)
	highest_score_ui.text = str(game_manager.player_highest_score)

func update_stamina(value):
	stamina_var.value = value

func update_stamina_label(text):
	$GameHUD/Control2/Label.text = "Stamina" + text

func on_player_death() -> void:
	is_game_over = true
	$GameOver/Canvas.can_replay = true
	$GameOver/Canvas.set_scores(game_manager.player_score, game_manager.player_highest_score)
	game_over_menu.open_ui()
	sound_manager.stop_bgm()
	player.queue_free()

func _on_game_won():
	
	
	game_manager._on_game_won()
