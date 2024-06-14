extends CharacterBody2D

@export var player : CharacterBody2D
@export var move_speed : float

func _input(event):
	if event.is_action_pressed("ui_left"):
		player.rotation_degrees -= 90
	elif event.is_action_pressed("ui_right"):
		player.rotation_degrees += 90
		

func _physics_process(delta):
	velocity += transform.x * move_speed * delta
	
	move_and_slide()
