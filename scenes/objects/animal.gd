extends Area2D
class_name Animal

## Animal script for Jasper, Mary, and Chester
## Animals appear when the correct food is placed

@export var animal_id: String = ""
@export var animal_name: String = "Animal"
@export_multiline var description: String = "A friendly animal."
@export var sprite_color: Color = Color.WHITE
@export var required_food: String = ""  # "milk", "seeds", or "parsley"

@onready var sprite: ColorRect = $Sprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var is_found: bool = false
var is_visible_to_player: bool = false

func _ready():
	# Set up collision layers
	collision_layer = 4
	collision_mask = 0
	
	# Set sprite color
	if sprite:
		sprite.color = sprite_color
	
	# Start hidden
	visible = false
	is_visible_to_player = false

func appear():
	"""Make the animal appear"""
	if not is_visible_to_player:
		is_visible_to_player = true
		visible = true
		
		# Play a simple appear animation
		scale = Vector2.ZERO
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		
		# Notify GameManager
		GameManager.find_animal(animal_id)
		is_found = true

func interact():
	"""Handle interaction with the animal"""
	if is_visible_to_player:
		show_animal_info()

func show_animal_info():
	"""Show information about this animal"""
	var viewer = get_tree().get_first_node_in_group("object_viewer")
	if viewer:
		# Create a temporary interactable object to show
		var temp_obj = InteractableObject.new()
		temp_obj.object_name = animal_name
		temp_obj.description = description
		temp_obj.sprite_color = sprite_color
		viewer.show_object(temp_obj)
		temp_obj.queue_free()

func highlight(enabled: bool):
	"""Highlight effect when player is nearby"""
	if is_visible_to_player:
		if enabled:
			modulate = Color(1.2, 1.2, 1.2)
		else:
			modulate = Color.WHITE

