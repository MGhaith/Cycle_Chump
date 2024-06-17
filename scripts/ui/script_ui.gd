extends CanvasLayer

# THIS IS A SCRIPT FOR EVERY UI
var is_tweening = false

func open_ui():
	is_tweening = true
	self.visible = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset:y", 0, 0.8)
	tween.play()
	await tween.finished
	is_tweening = false

func close_ui():
	is_tweening = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "offset:y", -1000, 0.8)
	tween.play()
	await tween.finished
	is_tweening = false
	self.visible = false
