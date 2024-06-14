extends VehicleBody3D

@onready var body_mesh = $Bike
@onready var front_wheel = $front/FrontWheel

@export var bike_speed = 5.0
@export var bike_max_speed = 8.0

@export var steer_angle = 20.0
var steer_speed = 3.0

func  _ready():
	constant_force.z = bike_speed

func _unhandled_input(event):
	if event.is_action_pressed("sprint"):
		print("sprinting")

func _physics_process(_delta):
	
	var input_dir = Input.get_axis("right", "left") * deg_to_rad(steer_angle)
	steering = lerp_angle(steering, input_dir, steer_speed)
	#front_wheel.rotation.y = input_dir
	#body_mesh.rotate(lerp(body_mesh.rotation_degrees, front_wheel.rotation_degrees, delta))
	
	#move_and_slide()
