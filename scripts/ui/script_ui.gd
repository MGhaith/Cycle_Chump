extends CanvasLayer

# THIS IS A SCRIPT FOR EVERY UI

func open_ui():
	self.visible = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset:y", 0, 0.8)
	tween.play()

func close_ui():
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "offset:y", -1000, 0.8)
	tween.play()
	await get_tree().create_timer(0.8).timeout
	self.visible = false
