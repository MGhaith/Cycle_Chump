extends Node3D

@export var game_scene: Node3D

var car_speed: float = .02

func _physics_process(_delta):
	global_position += transform.basis.z * car_speed 

func _on_kill_area_body_entered(body):
	if body.is_in_group("player"):
		if game_scene != null:
			game_scene.on_player_death()
		else:
			push_error("no game_scene on car")


func _on_turn_area_area_entered(area):
	if area.is_in_group("turn"):
		
		var next_turn_dir = area.pick_next()
		
		if next_turn_dir != null:
			var target_angle = atan2(next_turn_dir.x, next_turn_dir.z)
			
			self.rotation.y = target_angle
			
			global_position.x = round(global_position.x)
			global_position.z = round(global_position.z)

