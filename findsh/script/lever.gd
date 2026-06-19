extends Node3D

@onready var up_button = $Up_Button
@onready var down_button = $Down_Button

var moveable = true
var subposition = "coral"

func move_submarine(state: int):
	var submarine = get_tree().get_first_node_in_group("submarine")
	var ocean_node = get_tree().get_first_node_in_group("ocean")
	var tween_submarine = get_tree().create_tween()
	
	moveable = false
	
	match state:
		1:
			if subposition == "coral":
				return
			elif subposition == "abyss":
				subposition = "mid_ocean"
				if ocean_node:
					ocean_node.transition_ocean_depth(Color("0f2e55"), 25.0, 7.0)
				tween_submarine.tween_property(submarine, "global_position:y", submarine.global_position.y + 15, 7)
				
			elif subposition == "mid_ocean":
				subposition = "coral"
				if ocean_node:
					ocean_node.transition_ocean_depth(Color("1a867aff"), 40.0, 7.0)
				tween_submarine.tween_property(submarine, "global_position:y", submarine.global_position.y + 15, 7)
				
		2:
			if subposition == "abyss":
				return
			elif subposition == "coral":
				subposition = "mid_ocean"
				if ocean_node:
					ocean_node.transition_ocean_depth(Color("1a457aff"), 25.0, 10.0)
				tween_submarine.tween_property(submarine, "global_position:y", submarine.global_position.y - 15, 10)
				
			elif subposition == "mid_ocean":
				subposition = "abyss"
				if ocean_node:
					ocean_node.transition_ocean_depth(Color("01090e"), 10.0, 10.0)
				tween_submarine.tween_property(submarine, "global_position:y", submarine.global_position.y - 15, 10)
				
	await tween_submarine.finished
	moveable = true
	
func pressed_up(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if moveable and subposition != "coral":
				move_submarine(1)
	
func pressed_down(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if moveable and subposition != "abyss":
				move_submarine(2)
