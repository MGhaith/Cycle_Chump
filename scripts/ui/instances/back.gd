extends Button

@onready var click_sound = $ClickSound

func _on_button_down():
	click_sound.play()
