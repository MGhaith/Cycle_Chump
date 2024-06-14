extends CharacterBody3D

@export_category("Bike Mesh")
@export var front_wheel : Node

@export_category("Bike Values")
@export var bike_normal_speed = 5.0
@export var bike_fast_speed = 10.0

var bike_current_speed = 5.0

var steering = 0

func _physics_process(delta):
	 # sets the steering amount base on the speed of the bike
	steering = (bike_current_speed - 2)
	
	# gets the input axis (positive, negative)
	var input_dir = Input.get_axis("right", "left") * deg_to_rad(steering)
	
	# a function that helps change the speed
	if Input.is_action_pressed("shift"):
		bike_current_speed = bike_fast_speed
	else:
		bike_current_speed = bike_normal_speed
	
	
	rotate_y(input_dir / bike_current_speed)
	
	var direction = Vector3.ZERO
	
	direction = lerp(direction, (transform.basis * Vector3(input_dir, 0, 1)).normalized(), delta * bike_current_speed)
	
	velocity = velocity.normalized()
	velocity.x = direction.x * bike_current_speed 
	velocity.z = direction.z * bike_current_speed
	
	front_wheel.rotation.y = input_dir
	move_and_slide()
