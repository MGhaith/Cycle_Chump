extends Camera3D

@export var player : VehicleBody3D

var last_pos
var player_on_screen = true

func _process(delta):
	print(player_on_screen)
	
	if player_on_screen:
		last_pos = player.global_position
	else:
		var target_pos = Vector3(position.x, position.y, last_pos.z)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", target_pos, 0.5)
		tween.play()

func _on_player_screen_exited():
	player_on_screen = false

func _on_player_screen_entered():
	player_on_screen = true
