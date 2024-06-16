extends Area3D

@export var game_scene: Node3D

var point_value: int = 10

func _physics_process(_delta):
	if game_scene == null:
		return
	
	if has_overlapping_bodies():
		var overlaping_bodies = get_overlapping_bodies()
		for body in overlaping_bodies:
			if body.is_in_group("player"):
				game_scene.change_score(point_value)
				self.queue_free()

