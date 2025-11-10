extends CharacterBody2D

## Player character script
## Handles movement, interaction detection, and flashlight control

@export var speed: float = 200.0
@export var interaction_range: float = 80.0

@onready var flashlight: PointLight2D = $Flashlight
@onready var interaction_area: Area2D = $InteractionArea

@onready var _animated_sprite = $AnimatedSprite2D

var nearby_interactables: Array[Node] = []
var can_move: bool = true

func _ready():
	# Set up interaction area
	interaction_area.body_entered.connect(_on_interactable_entered)
	interaction_area.body_exited.connect(_on_interactable_exited)
	interaction_area.area_entered.connect(_on_interactable_area_entered)
	interaction_area.area_exited.connect(_on_interactable_area_exited)

func _physics_process(delta: float):
	if can_move:
		handle_movement(delta)
		handle_interaction()

func handle_movement(delta: float):
	# Get movement input from InputManager
	var input_vector = InputManager.get_movement_vector()
	
	if input_vector != Vector2.ZERO:
		# Move the player
		velocity = input_vector * speed
		
		# Play appropriate animation based on movement direction
		# Prioritize horizontal or vertical based on which component is larger
		if abs(input_vector.x) > abs(input_vector.y):
			# Moving more horizontally
			if input_vector.x > 0:
				_animated_sprite.play("walk-right")
			else:
				_animated_sprite.play("walk-left")
		else:
			# Moving more vertically
			if input_vector.y > 0:
				_animated_sprite.play("walk-down")
			else:
				_animated_sprite.play("walk-up")
	else:
		velocity = Vector2.ZERO
		_animated_sprite.stop()
	
	move_and_slide()

func handle_interaction():
	if InputManager.is_interact_just_pressed() and nearby_interactables.size() > 0:
		# Interact with the closest object
		var closest = get_closest_interactable()
		if closest and closest.has_method("interact"):
			closest.interact()

func get_closest_interactable() -> Node:
	if nearby_interactables.is_empty():
		return null
	
	var closest = nearby_interactables[0]
	var closest_distance = global_position.distance_to(closest.global_position)
	
	for interactable in nearby_interactables:
		var distance = global_position.distance_to(interactable.global_position)
		if distance < closest_distance:
			closest = interactable
			closest_distance = distance
	
	return closest

func _on_interactable_entered(body: Node2D):
	if body.has_method("interact") and body not in nearby_interactables:
		nearby_interactables.append(body)
		if body.has_method("highlight"):
			body.highlight(true)

func _on_interactable_exited(body: Node2D):
	if body in nearby_interactables:
		nearby_interactables.erase(body)
		if body.has_method("highlight"):
			body.highlight(false)

func _on_interactable_area_entered(area: Area2D):
	# The area itself is the InteractableObject (extends Area2D)
	if area.has_method("interact") and area not in nearby_interactables:
		nearby_interactables.append(area)
		if area.has_method("highlight"):
			area.highlight(true)

func _on_interactable_area_exited(area: Area2D):
	# The area itself is the InteractableObject (extends Area2D)
	if area in nearby_interactables:
		nearby_interactables.erase(area)
		if area.has_method("highlight"):
			area.highlight(false)

func set_can_move(value: bool):
	"""Enable or disable player movement (useful when viewing objects)"""
	can_move = value
	if not can_move:
		velocity = Vector2.ZERO
