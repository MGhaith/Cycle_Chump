extends Node

@export var pick_player: AudioStreamPlayer
@export var bgm_player: AudioStreamPlayer
@export var siren_player: AudioStreamPlayer

func play_point_pick():
	pick_player.play()

func stop_bgm() -> void:
	bgm_player.volume_db = lerp(float(bgm_player.volume_db), -80.0, 0.2)
	await(get_tree().create_timer(.1).timeout)
	play_siren()

func play_siren():
	siren_player.play()

func _on_siren_player_finished():
	bgm_player.volume_db = 0.0
