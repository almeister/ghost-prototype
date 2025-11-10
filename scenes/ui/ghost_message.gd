extends CanvasLayer

## Ghost Message system displays narrative messages from the ghost
## Shows atmospheric story messages at key moments

@onready var panel: Panel = $Panel
@onready var message_label: RichTextLabel = $Panel/VBoxContainer/MessageLabel
@onready var continue_label: Label = $Panel/VBoxContainer/ContinueLabel

var message_queue: Array[String] = []
var is_displaying: bool = false
var current_message: String = ""
var player: CharacterBody2D = null

func _ready():
	# Add to group for easy access
	add_to_group("ghost_message")
	
	# Hide by default
	visible = false
	
	# Connect to GameManager signal
	GameManager.ghost_message.connect(_on_ghost_message)
	
	# Find player
	call_deferred("find_player")

func find_player():
	"""Find the player in the scene"""
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event):
	# Dismiss with dedicated back button (Backspace/B), Escape, or interact button
	if is_displaying and (event.is_action_released("ui_back") or event.is_action_released("ui_cancel") or event.is_action_released("interact")):
		dismiss_message()
		get_viewport().set_input_as_handled()

func _on_ghost_message(message: String):
	"""Handle incoming ghost message"""
	message_queue.append(message)
	if not is_displaying:
		show_next_message()

func show_next_message():
	"""Display the next message in the queue"""
	if message_queue.is_empty():
		is_displaying = false
		visible = false
		# Resume player movement
		if player and player.has_method("set_can_move"):
			player.set_can_move(true)
		return
	
	current_message = message_queue.pop_front()
	is_displaying = true
	visible = true
	
	# Pause player movement
	if player and player.has_method("set_can_move"):
		player.set_can_move(false)
	
	if message_label:
		message_label.text = "[center][i]" + current_message + "[/i][/center]"

func dismiss_message():
	"""Dismiss the current message and show next"""
	show_next_message()

