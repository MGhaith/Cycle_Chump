extends Control

@export var controls_menu : CanvasLayer
@export var credits_menu : CanvasLayer

signal play_transition 

func _on_play_button_down():
	emit_signal("play_transition")

func _on_controls_button_down():
	controls_menu.open_ui()

