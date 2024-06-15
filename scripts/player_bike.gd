extends VehicleBody3D

@export_category("Bike Mesh")
@export var front_wheel_mesh : MeshInstance3D
@export var front_wheel : VehicleWheel3D
@export var rear_wheel : VehicleWheel3D

@export_category("Bike Values")
@export var steer_angle = 20.0
@export var steer_speed = 2.0

@export_category("Bike Speeds Mesure In Kilometres")
@export var bike_normal_speed = 5.0
@export var bike_slow_speed = 10.0

var bike_current_speed = 5.0

var is_on_ground = false
var is_steering_lean = false

func _physics_process(delta):
	 # sets the steering amount base on the speed of the bike
	
	# gets the input axis (positive, negative)
	var input_dir = Input.get_axis("right", "left")
	
	# a function that helps change the speed
	if Input.is_action_pressed("sprint"):
		bike_current_speed = bike_slow_speed
	else:
		bike_current_speed = bike_normal_speed
	
	
	engine_force = lerp(engine_force, bike_current_speed, delta )
	
	steering = lerp_angle(steering, input_dir * deg_to_rad(steer_angle), steer_speed * delta)
	
	var target_rotation = input_dir * steer_angle
	front_wheel_mesh.rotation_degrees.y = lerp(front_wheel_mesh.rotation_degrees.y, target_rotation, steer_speed * delta)

func _integrate_forces(state):
	
	if front_wheel.is_in_contact() or rear_wheel.is_in_contact():
		is_on_ground = true
	else:
		is_on_ground = false
	
	var current_velocity = state.transform.basis.inverse() * linear_velocity
	var negative_vel = current_velocity.z
	
	
	if negative_vel >= 15:
		is_steering_lean = true
	elif negative_vel < 13:
		is_steering_lean = false
	
	var input_dir = Input.get_axis("right", "left")
	
	if is_on_ground:
		if is_steering_lean:
			angular_velocity = lerp(angular_velocity, -state.transform.basis.z * input_dir, 0.1)
			steering = lerp(steering, rotation.z / 2, 0.1)
		elif abs(rotation_degrees.z) >= 1:
			angular_velocity = lerp(angular_velocity, -state.transform.basis.z * sign(rotation_degrees.z), 0.1)
		else:
			angular_velocity.x = 0
			angular_velocity.z = 0
	
	
