extends CanvasLayer

# THIS IS A SCRIPT FOR EVERY UI

func open_ui():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "offset:y", Vector2(0,0), 0.5)

func close_ui():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "offset:y", Vector2(0,-1000), 0.5)
