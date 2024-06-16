extends Node3D

signal game_won

@export var win_area: Area3D
@export var meshs: Node3D

func enable_win_area() -> void:
	meshs.visible = false
	win_area.monitoring = true

func _on_win_area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("game_won")
