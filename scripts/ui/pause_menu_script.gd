extends Control

#@export var 
#@export var 

@onready var menu = preload("res://scenes/ui/menu_ui.tscn").instantiate()
@onready var game_manager = get_tree().current_scene

func _input(event):
	if get_tree().paused and !self.get_parent().is_tweening:
		if event.is_action_pressed("escape"):
			_on_resume_button_down()

func _on_resume_button_down():
	self.get_parent().close_ui()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false

func _on_restart_button_down():
	game_manager.game_transition()
	get_tree().paused = false

func _on_main_menu_button_down():
	get_tree().paused = false
	game_manager._reload_game()
	
