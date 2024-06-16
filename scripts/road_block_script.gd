extends Node3D

signal game_won

@export var win_area: Area3D
@export var meshs: Node3D

func enable_win_area() -> void:
	$StaticBody3D/CollisionShape3D.disabled = true
	meshs.visible = false
	win_area.monitoring = true
	

func _on_win_area_body_entered(body):
	if body.is_in_group("player"):
		print("here")
		emit_signal("game_won")
