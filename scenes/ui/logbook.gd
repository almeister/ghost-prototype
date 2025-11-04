extends CanvasLayer

## Logbook UI displays discovered tasks and found animals
## Accessible via Tab key or controller Select button

@onready var panel: Panel = $Panel
@onready var title_label: Label = $Panel/VBoxContainer/TitleLabel
@onready var tasks_container: VBoxContainer = $Panel/VBoxContainer/ScrollContainer/TasksList
@onready var animals_label: Label = $Panel/VBoxContainer/AnimalsFoundLabel
@onready var close_button: Button = $Panel/VBoxContainer/CloseButton

var is_open: bool = false
var player: CharacterBody2D = null

func _ready():
	# Add to group for easy access
	add_to_group("logbook")
	
	# Hide by default
	visible = false
	
	# Connect to GameManager signals
	GameManager.task_discovered.connect(_on_task_discovered)
	GameManager.task_completed.connect(_on_task_completed)
	GameManager.animal_found.connect(_on_animal_found)
	
	# Connect close button
	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	
	# Find player
	call_deferred("find_player")

func find_player():
	"""Find the player in the scene"""
	player = get_tree().get_first_node_in_group("player")

func _input(event):
	if InputManager.is_logbook_just_pressed():
		toggle_logbook()
	elif is_open and Input.is_action_just_pressed("ui_cancel"):
		close_logbook()

func toggle_logbook():
	"""Toggle the logbook open/closed"""
	if is_open:
		close_logbook()
	else:
		open_logbook()

func open_logbook():
	"""Open the logbook"""
	is_open = true
	visible = true
	
	# Update display
	update_display()
	
	# Pause player movement
	if player and player.has_method("set_can_move"):
		player.set_can_move(false)

func close_logbook():
	"""Close the logbook"""
	is_open = false
	visible = false
	
	# Resume player movement
	if player and player.has_method("set_can_move"):
		player.set_can_move(true)

func update_display():
	"""Update the logbook display with current tasks and animals"""
	# Clear existing task labels
	for child in tasks_container.get_children():
		child.queue_free()
	
	# Get discovered tasks from GameManager
	var tasks = GameManager.get_discovered_tasks()
	
	if tasks.is_empty():
		var no_tasks = Label.new()
		no_tasks.text = "No tasks discovered yet. Explore the house to find clues!"
		no_tasks.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		tasks_container.add_child(no_tasks)
	else:
		for task in tasks:
			var task_label = Label.new()
			var status = "[✓]" if task["completed"] else "[ ]"
			task_label.text = status + " " + task["name"]
			task_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			
			# Add description as secondary label
			var desc_label = Label.new()
			desc_label.text = "    " + task["description"]
			desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			desc_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
			
			tasks_container.add_child(task_label)
			tasks_container.add_child(desc_label)
			
			# Add spacing
			var spacer = Control.new()
			spacer.custom_minimum_size = Vector2(0, 10)
			tasks_container.add_child(spacer)
	
	# Update animals found
	if animals_label:
		var count = GameManager.get_animals_found()
		var total = GameManager.get_total_animals()
		animals_label.text = "Animals Found: " + str(count) + " / " + str(total)

func _on_task_discovered(task_name: String):
	"""Handle task discovery"""
	if is_open:
		update_display()

func _on_task_completed(task_name: String):
	"""Handle task completion"""
	if is_open:
		update_display()

func _on_animal_found(animal_name: String):
	"""Handle animal found"""
	if is_open:
		update_display()

func _on_close_pressed():
	"""Handle close button press"""
	close_logbook()

