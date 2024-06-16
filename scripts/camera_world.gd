extends Camera3D

@export var player : VehicleBody3D

var player_on_screen = true

func _process(_delta):
	if player != null:
		self.position = Vector3(position.x, position.y, player.position.z)
