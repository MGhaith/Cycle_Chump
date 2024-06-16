extends CanvasLayer


func transition_in():
	self.visible = true
	self.offset.y = -1000
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset:y", 0, 0.8)
	tween.play()

func transition_out():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "offset:y", 1000, 0.8)
	tween.play()
	await get_tree().create_timer(0.8).timeout
	self.visible = false
