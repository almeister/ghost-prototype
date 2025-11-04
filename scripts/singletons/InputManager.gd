extends Node

## InputManager handles all input for controller (primary) and keyboard (fallback)
## Provides centralized input handling for the game

func get_movement_vector() -> Vector2:
	"""Returns normalized movement vector from input"""
	var input_vector = Vector2.ZERO
	
	# Get input from both keyboard and controller
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	# Normalize diagonal movement
	return input_vector.normalized()

func is_interact_just_pressed() -> bool:
	"""Check if interact button was just pressed"""
	return Input.is_action_just_pressed("interact")

func is_logbook_just_pressed() -> bool:
	"""Check if logbook toggle was just pressed"""
	return Input.is_action_just_pressed("toggle_logbook")

func get_controller_connected() -> bool:
	"""Check if any controller is connected"""
	return Input.get_connected_joypads().size() > 0

func vibrate_controller(weak_magnitude: float = 0.5, strong_magnitude: float = 0.5, duration: float = 0.2):
	"""Vibrate the controller if one is connected"""
	if get_controller_connected():
		var joypads = Input.get_connected_joypads()
		for joypad_id in joypads:
			Input.start_joy_vibration(joypad_id, weak_magnitude, strong_magnitude, duration)
