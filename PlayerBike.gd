extends CharacterBody3D

@onready var body_mesh = $Bike
@onready var front_wheel = $FrontWheel

@export var bike_speed = 5.0
@export var steering = 18.0
@export var gravity = 9.0


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_axis("right", "left") * deg_to_rad(steering)
	front_wheel.rotation.y = input_dir
	
	
	velocity.z = bike_speed * delta
	
	move_and_slide()
