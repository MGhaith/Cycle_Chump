extends VehicleBody3D

@onready var AnimationController = $BicycleMesh/AnimationPlayer
@onready var visible_on_screen_enabler_3d = $VisibleOnScreenEnabler3D
@onready var ring_sound = $RingSound


@export_category("Bike Properties")
@export var game_scene: Node3D
@export var stamina_timer : Timer

@export_category("Bike Mesh")
@export var front_wheel_mesh : MeshInstance3D
@export var body_mesh : MeshInstance3D
@export var front_wheel : VehicleWheel3D
@export var rear_wheel : VehicleWheel3D

#_________

@export_category("Bike Steer Values")
@export var steer_angle = 45.0
@export var steer_speed = 15.0

#_________

@export_category("Bike Speeds Mesure In Kilometres")
@export var bike_normal_speed = 15.0
@export var bike_max_speed = 30.0

#_________$StaminaTimer

@export_category("Stamina System")
@export var current_stamina = 100.0
@export var stamina_gain_per_banana = 10
@export var stamina_gain_per_break = 1

## This max stamina remover helps when the player is using the bike full speed
@export var max_stamina_remover = 1

## This min stamina remover helps when the player is using the bike at normal speed
@export var min_stamina_remover = .5

var bike_current_speed = bike_normal_speed

var is_on_ground = false
var is_steering_lean = false
var is_bike_flipping = false
var can_move: bool = true
var bike_break = false
var current_dir = "right"

func _ready():
	game_scene.update_stamina(current_stamina)

func _stamina_timer():
	if can_move:
		if bike_current_speed > bike_normal_speed:
			current_stamina -= max_stamina_remover
		else:
			current_stamina -= min_stamina_remover
	else:
		current_stamina += .5
		game_scene.update_stamina_label(" (Resting)")
	
	if game_scene != null:
		game_scene.update_stamina(current_stamina)

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		AnimationController.stop()
		stamina_timer.stop()
		can_move = false
		stamina_timer.wait_time = 1
		stamina_timer.start()
	
	if Input.is_action_just_released("space"):
		global_position = global_position
		AnimationController.play()
		stamina_timer.stop()
		can_move = true
		stamina_timer.wait_time = 3.0
		stamina_timer.start()
	
	if current_stamina <= 0.0:
		AnimationController.stop()
		current_stamina = 0.1
		stamina_timer.stop()
		can_move = false
		stamina_timer.wait_time = 1
		stamina_timer.start()
	elif current_stamina >= 100.0:
		AnimationController.play()
		stamina_timer.stop()
		current_stamina = 99.9
		can_move = true
		stamina_timer.wait_time = 3.0
		stamina_timer.start()

func _physics_process(delta):
	if can_move:
		
		
		if bike_break: return
		engine_force = bike_current_speed
		
		
		
		if Input.is_action_pressed("left"):
			rotation_degrees.y = -90
			current_dir = "left"
		elif Input.is_action_pressed("right"):
			rotation_degrees.y = 90
			current_dir = "right"
		elif Input.is_action_pressed("up"):
			rotation_degrees.y = 180
			current_dir = "up"
		elif Input.is_action_pressed("down"):
			rotation_degrees.y = 0
			current_dir = "down"
		
		# Adjust speed based on input
		if Input.is_action_pressed("sprint"):
			bike_current_speed = bike_max_speed
			game_scene.update_stamina_label(" (Sprinting x2)")
		else:
			bike_current_speed = bike_normal_speed
			game_scene.update_stamina_label("")
		# Update animation speed
		AnimationController.speed_scale = engine_force / bike_current_speed + delta
		# Reset linear velocity if the bike can't move
	else:
		linear_velocity = lerp(linear_velocity, Vector3.ZERO, 2)

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

func _banana_area_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("banana"):
		
		var preview_stamina = current_stamina + stamina_gain_per_banana
	
		if preview_stamina > 100:
			current_stamina = 100
		else:
			current_stamina += stamina_gain_per_banana
		
		$banana_crunch.play()
		
		area.queue_free()

func _input(event):
	if event.is_action_pressed("ring"):
		ring_sound.play()
