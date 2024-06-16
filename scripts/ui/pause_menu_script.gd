extends Control

@onready var menu = preload("res://scenes/ui/menu_ui.tscn").instantiate()

func _on_resume_button_down():
	self.get_parent().close_ui()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false

func _on_main_menu_button_down():
	get_tree().change_scene_to_packed(menu)
