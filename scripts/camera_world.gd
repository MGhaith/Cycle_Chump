extends Camera3D

@export var player : VehicleBody3D

var player_on_screen = true

func _process(delta):
	self.position = Vector3(position.x, position.y, player.position.z)
