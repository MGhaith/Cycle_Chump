extends TextureButton

@export var text : String
@onready var text_node = $Text
@onready var hover_sound = $HoverSound
@onready var click_sound = $ClickSound

func _ready():
	text_node.text = text

func _on_button_down():
	text_node.position.y += 2
	click_sound.play()
func _on_button_up():
	text_node.position.y -= 2
func _on_mouse_entered():
	text_node.position.y += 4
	hover_sound.play()
func _on_mouse_exited():
	text_node.position.y -= 4
