extends Control

@export var score_ui: Label
@export var best_score_ui: Label

var can_replay: bool

func _ready():
	can_replay = false

func _process(_delta):
	if can_replay:
		if Input.is_action_just_pressed("space"):
			get_tree().current_scene.game_transition()

func set_scores(player_score, player_highest_score):
	score_ui.text = "Score : " + str(player_score)
	best_score_ui.text = "Score : " + str(player_highest_score)
