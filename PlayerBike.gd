extends RigidBody3D

@onready var body_mesh = $Bike
@onready var front_wheel = $FrontWheel

@export var bike_speed = 20.0
@export var bike_max_speed = 25.0

@export var steering = 18.0
var steer_speed = 0.1

func _unhandled_input(event):
	if event.is_action_pressed("sprint"):
		print("sprinting")

func _physics_process(_delta):
	
	var input_dir = Input.get_axis("right", "left") * deg_to_rad(steering)
	front_wheel.rotation.y = lerp(front_wheel.rotation.y, input_dir, .1)
	
	apply_force(front_wheel.basis.z * bike_speed)
