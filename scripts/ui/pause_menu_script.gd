extends Control

@onready var menu = preload("res://scenes/ui/menu_ui.tscn").instantiate()
@onready var _menu = self.get_parent().get_parent().get_parent().get_parent()

func _on_resume_button_down():
	self.get_parent().close_ui()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false

func _on_restart_button_down():
	_menu._on_game_won()
	get_tree().paused = false

func _on_main_menu_button_down():
	get_tree().paused = false
	_menu._reload_game()
	
