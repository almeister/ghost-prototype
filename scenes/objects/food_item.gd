extends Area2D
class_name FoodItem

## Food item that can be placed to lure animals
## When placed in the correct location, the associated animal will appear

@export var food_type: String = "milk"  # "milk", "seeds", or "parsley"
@export var food_name: String = "Food"
@export_multiline var description: String = "Food for an animal."
@export var sprite_color: Color = Color.WHITE
@export var target_animal: String = ""  # "jasper", "mary", or "chester"

@onready var sprite: ColorRect = $Sprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var is_placed: bool = false

func _ready():
	# Set up collision layers
	collision_layer = 4
	collision_mask = 0
	
	# Set sprite color
	if sprite:
		sprite.color = sprite_color

func interact():
	"""Called when player interacts with this food item"""
	if not is_placed:
		place_food()

func place_food():
	"""Place the food and trigger animal appearance"""
	is_placed = true
	
	# Notify GameManager
	GameManager.place_food(target_animal)
	
	# Find and summon the associated animal
	call_deferred("summon_animal")
	
	# Show feedback message
	GameManager.show_ghost_message("The food has been placed. Now we wait...")

func summon_animal():
	"""Summon the associated animal after a short delay"""
	await get_tree().create_timer(2.0).timeout
	
	# Find the animal in the scene
	var animals = get_tree().get_nodes_in_group("animals")
	for animal in animals:
		if animal is Animal and animal.animal_id == target_animal:
			animal.appear()
			break

func highlight(enabled: bool):
	"""Highlight effect when player is nearby"""
	if not is_placed:
		if enabled:
			modulate = Color(1.2, 1.2, 1.2)
		else:
			modulate = Color.WHITE
