extends VehicleBody3D

@onready var AnimationController = $BicycleMesh/AnimationPlayer
@onready var stamina_timer = $StaminaTimer
@onready var visible_on_screen_enabler_3d = $VisibleOnScreenEnabler3D

@export_category("Bike Properties")
@export var camara_world : Camera3D

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
@export var bike_normal_speed = 25.0
@export var bike_max_speed = 45.0

#_________

@export_category("Stamina System")
@export var current_stamina = 100.0
@export var stamina_gain_per_banana = 10

## This max stamina remover helps when the player is using the bike full speed
@export var max_stamina_remover = 5.0

## This min stamina remover helps when the player is using the bike at normal speed
@export var min_stamina_remover = 2.0

var bike_current_speed = bike_normal_speed

var is_on_ground = false
var is_steering_lean = false

var is_bike_flipping = false

func _ready():
	if not camara_world:
		printerr("Player needs a camara to work, assign the camara on player bike properties")
	else:
		visible_on_screen_enabler_3d.screen_exited.connect(Callable(camara_world, "_on_player_screen_exited"))
		visible_on_screen_enabler_3d.screen_entered.connect(Callable(camara_world, "_on_player_screen_entered"))

func _stamina_timer():
	if bike_current_speed > bike_normal_speed:
		current_stamina -= max_stamina_remover
	else:
		current_stamina -= min_stamina_remover

func _process(_delta):
	if current_stamina == 0:
		engine_force = 0

func _physics_process(delta):
	# gets the input axis (positive, negative)
	var input_dir = Input.get_axis("right", "left")
	
	# a function that helps change the speed
	if Input.is_action_pressed("sprint"):
		bike_current_speed = bike_max_speed
	else:
		bike_current_speed = bike_normal_speed
	
	
	engine_force = lerp(engine_force, bike_current_speed, delta )
	AnimationController.speed_scale = engine_force / bike_current_speed + delta

	steering = lerp_angle(steering, input_dir * deg_to_rad(steer_angle), steer_speed * delta)
	
	var target_rotation = input_dir * steer_angle
	front_wheel_mesh.rotation_degrees.y = lerp(front_wheel_mesh.rotation_degrees.y, target_rotation, steer_speed * delta)
	body_mesh.rotation_degrees.y = lerp(body_mesh.rotation_degrees.y tet_rotation)

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

func _banana_area_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("banana"):
		print("Gain stamina")
		var banana_children = area.get_children()

		# Play the animations "picked" from the banana before queue_freeing
		for child in banana_children:
			if child is AnimationPlayer:
				var banana_animations : AnimationPlayer = child
				banana_animations.play("picked")

		var preview_stamina = current_stamina + stamina_gain_per_banana
	
		if preview_stamina > 100:
			current_stamina = 100
		else:
			current_stamina + stamina_gain_per_banana

		await get_tree().create_timer(1).timeout
		area.queue_free()


func _input(event):
	if event.is_action_pressed("space") and !is_bike_flipping:
		is_bike_flipping = true
		var tween = get_tree().create_tween()
		engine_force = 0
		tween.tween_property(self, "position", Vector3(position.x, position.y + 0.5, position.z), 0.5)
		tween.tween_property(self, "rotation_degrees:y", rotation_degrees.y + 180, 0.5)
		engine_force = 10
		tween.play()
		await get_tree().create_timer(2).timeout
		is_bike_flipping = false
