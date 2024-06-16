extends Area3D

@export var pickup_player: AudioStreamPlayer
@export var level_root: Node3D

var point_value: int = 10

func _physics_process(_delta):
	if level_root == null:
		return
	
	if has_overlapping_bodies():
		var overlaping_bodies = get_overlapping_bodies()
		for body in overlaping_bodies:
			if body.is_in_group("player"):
				level_root.change_score(point_value)
				pickup_player.play()
				self.queue_free()

