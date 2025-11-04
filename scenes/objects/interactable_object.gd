extends Area2D
class_name InteractableObject

## Base class for all interactable objects in the game
## Handles interaction, highlighting, and basic properties

enum ObjectType { CLUE, TASK, RED_HERRING, FOOD, ANIMAL }

@export var object_id: String = ""
@export var object_name: String = "Object"
@export_multiline var description: String = "An object."
@export var object_type: ObjectType = ObjectType.CLUE
@export var sprite_color: Color = Color.WHITE
@export var discovered: bool = false

# For task objects
@export var task_id: String = ""
@export_multiline var task_description: String = ""

# For clue objects
@export var clue_keywords: Array[String] = []

@onready var sprite: ColorRect = $Sprite
@onready var highlight_sprite: ColorRect = $HighlightSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var is_highlighted: bool = false

func _ready():
	# Set up collision layers
	collision_layer = 4  # Interactable layer
	collision_mask = 0
	
	# Set sprite color
	if sprite:
		sprite.color = sprite_color
	
	# Hide highlight by default
	if highlight_sprite:
		highlight_sprite.visible = false
	
	# Connect to area signals if needed
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func interact():
	"""Called when player interacts with this object"""
	if not discovered:
		discovered = true
		GameManager.discover_object(object_id)
	
	# Notify GameManager if this is a task
	if object_type == ObjectType.TASK and task_id != "":
		GameManager.discover_task(task_id)
	
	# Show the object viewer
	show_object_viewer()

func show_object_viewer():
	"""Display this object in the object viewer UI"""
	var viewer = get_tree().get_first_node_in_group("object_viewer")
	if viewer:
		viewer.show_object(self)

func highlight(enabled: bool):
	"""Enable or disable the highlight effect"""
	is_highlighted = enabled
	if highlight_sprite:
		highlight_sprite.visible = enabled

func _on_body_entered(body):
	"""Handle body entering interaction area"""
	pass

func _on_body_exited(body):
	"""Handle body exiting interaction area"""
	pass

func get_display_text() -> String:
	"""Get the formatted display text for this object"""
	var text = description
	
	# Add task information if this is a task object
	if object_type == ObjectType.TASK and task_description != "":
		text += "\n\n[TASK DISCOVERED]\n" + task_description
	
	return text

