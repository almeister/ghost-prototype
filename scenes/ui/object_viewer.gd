extends CanvasLayer

## ObjectViewer displays detailed information about interactable objects
## Shows object name, description, and allows the player to close the view

@onready var panel: Panel = $Panel
@onready var title_label: Label = $Panel/VBoxContainer/TitleLabel
@onready var description_label: RichTextLabel = $Panel/VBoxContainer/DescriptionLabel
@onready var close_button: Button = $Panel/VBoxContainer/CloseButton
@onready var object_sprite: ColorRect = $Panel/VBoxContainer/ObjectSprite

var current_object: InteractableObject = null
var player: CharacterBody2D = null

func _ready():
	# Add to group for easy access
	add_to_group("object_viewer")
	
	# Hide by default
	visible = false
	
	# Connect close button
	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	
	# Find player reference
	call_deferred("find_player")

func find_player():
	"""Find the player in the scene"""
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event):
	# Close with dedicated back button (Backspace/B) or Escape
	if visible and (event.is_action_released("ui_back") or event.is_action_released("ui_cancel")):
		close_viewer()
		get_viewport().set_input_as_handled()

func show_object(obj: InteractableObject):
	"""Display an object in the viewer"""
	current_object = obj
	
	if title_label:
		title_label.text = obj.object_name
	
	if description_label:
		description_label.text = obj.get_display_text()
	
	if object_sprite:
		object_sprite.color = obj.sprite_color
	
	# Pause player movement
	if player and player.has_method("set_can_move"):
		player.set_can_move(false)
	
	# Show the viewer
	visible = true
	
	# Pause game tree (optional, comment out if you want background to keep animating)
	# get_tree().paused = true

func close_viewer():
	"""Close the object viewer"""
	visible = false
	current_object = null
	
	# Resume player movement
	if player and player.has_method("set_can_move"):
		player.set_can_move(true)
	
	# Unpause game tree
	# get_tree().paused = false

func _on_close_pressed():
	"""Handle close button press"""
	close_viewer()

