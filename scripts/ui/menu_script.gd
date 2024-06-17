extends CanvasLayer

@onready var controls_menu = $ControlsMenu

signal play_transition 

func _on_play_button_down():
	emit_signal("play_transition")

func _on_controls_button_down():
	controls_menu.open_ui()

func _on_exit_button_down():
	get_tree().quit()
