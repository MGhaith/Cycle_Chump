extends Area3D

var game_manager: GameManager
var point_value: int = 10

func _physics_process(_delta):
	if game_manager == null:
		return
	
	if has_overlapping_bodies():
		var overlaping_bodies = get_overlapping_bodies()
		for body in overlaping_bodies:
			if body.is_in_group("player"):
				game_manager.change_score(point_value)
				self.queue_free()

