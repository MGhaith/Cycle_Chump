extends Control

@export var menu : PackedScene

func _on_play_again_button_down():
	printerr("We Need To Set Up Here")

func _on_main_menu_button_down():
	get_tree().change_scene_to_packed(menu)
