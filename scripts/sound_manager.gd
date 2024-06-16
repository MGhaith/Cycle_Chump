extends Node

@export var pick_player : AudioStreamPlayer
@export var bgm_player : AudioStreamPlayer

func play_point_pick():
	pick_player.play()
func _ready():
	await get_tree().create_timer(0.7).timeout
	bgm_player.play()
