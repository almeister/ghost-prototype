extends CanvasLayer

## Ghost Message system displays narrative messages from the ghost
## Shows atmospheric story messages at key moments

@onready var panel: Panel = $Panel
@onready var message_label: RichTextLabel = $Panel/VBoxContainer/MessageLabel
@onready var continue_label: Label = $Panel/VBoxContainer/ContinueLabel

var message_queue: Array[String] = []
var is_displaying: bool = false
var current_message: String = ""

func _ready():
	# Add to group for easy access
	add_to_group("ghost_message")
	
	# Hide by default
	visible = false
	
	# Connect to GameManager signal
	GameManager.ghost_message.connect(_on_ghost_message)

func _input(event):
	if is_displaying:
		if InputManager.is_interact_just_pressed() or Input.is_action_just_pressed("ui_accept"):
			dismiss_message()

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
		return
	
	current_message = message_queue.pop_front()
	is_displaying = true
	visible = true
	
	if message_label:
		message_label.text = "[center][i]" + current_message + "[/i][/center]"

func dismiss_message():
	"""Dismiss the current message and show next"""
	show_next_message()

