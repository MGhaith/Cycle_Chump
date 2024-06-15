extends Area3D

@export var node_up: Area3D = null
@export var node_down: Area3D = null
@export var node_right: Area3D = null
@export var node_left: Area3D = null


var next_turns: Array = []
@export var is_one_turn: bool = false

func _ready():
	if node_up != null:
		next_turns.append(node_up)
	if node_down != null:
		next_turns.append(node_down)
	if node_right != null:
		next_turns.append(node_right)
	if node_left != null:
		next_turns.append(node_left)

func pick_next():
	if next_turns == []:
		push_error("no possible turns")
		return 
	
	var next_node = next_turns.pick_random()
	var direction = next_node.global_position - self.global_position
	
	return direction
