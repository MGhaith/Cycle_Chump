extends Node
class_name GameManager

signal level_done

@export var game_scene : PackedScene

@onready var transition = $Transition
@onready var main_menu = $MainMenu
@onready var menu = $Menu

var player_highest_score: int = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func game_transition():
	var game_scene_int = game_scene.instantiate()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	transition.transition_in()
	await get_tree().create_timer(0.8).timeout
	main_menu.queue_free()
	menu.queue_free()
	add_child(game_scene_int)
	transition.transition_out()
	await get_tree().create_timer(0.8).timeout
	

#func _process(_delta):
	#

func quit_game():
	get_tree().quit()

func _on_game_won():
	pass # Replace with function body.
