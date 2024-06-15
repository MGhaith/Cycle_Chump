extends Area3D

var game_manager: GameManager

func _physics_process(_delta):
	if game_manager == null:
		return
	
	if has_overlapping_bodies():
		var overlaping_bodies = get_overlapping_bodies()
		for body in overlaping_bodies:
			if body.is_in_group("player"):
				game_manager.change_score(100)
				self.queue_free()

