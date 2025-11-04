extends Node

## GameManager handles game state, progress tracking, and win conditions

signal task_discovered(task_name: String)
signal task_completed(task_name: String)
signal animal_found(animal_name: String)
signal game_won()
signal ghost_message(message: String)

# Game state
var discovered_objects: Array[String] = []
var completed_tasks: Array[String] = []
var found_animals: Array[String] = []
var food_placed: Dictionary = {}  # {animal_name: bool}

# Task definitions
var tasks: Dictionary = {
	"milk_for_jasper": {
		"name": "Leave milk for Jasper",
		"description": "Place a saucer of milk in the kitchen for Jasper the cat",
		"completed": false,
		"discovered": false
	},
	"seeds_for_mary": {
		"name": "Leave seeds for Mary", 
		"description": "Place sunflower seeds near the bedroom window for Mary the bird",
		"completed": false,
		"discovered": false
	},
	"parsley_for_chester": {
		"name": "Leave parsley for Chester",
		"description": "Place fresh parsley in the bathroom for Chester the rabbit",
		"completed": false,
		"discovered": false
	}
}

# Animal definitions
const ANIMALS = {
	"jasper": "Jasper the Cat",
	"mary": "Mary the Bird", 
	"chester": "Chester the Rabbit"
}

var game_started: bool = false
var first_clue_found: bool = false

func _ready():
	pass

func start_game():
	"""Initialize the game"""
	game_started = true
	show_ghost_message("Welcome, child... This house holds memories of love and loss. Help me find peace...")

func discover_object(object_id: String):
	"""Mark an object as discovered"""
	if object_id not in discovered_objects:
		discovered_objects.append(object_id)

func discover_task(task_id: String):
	"""Discover a new task"""
	if task_id in tasks and not tasks[task_id]["discovered"]:
		tasks[task_id]["discovered"] = true
		task_discovered.emit(tasks[task_id]["name"])
		
		# Show ghost message after first task/clue
		if not first_clue_found:
			first_clue_found = true
			show_ghost_message("Yes... my beloved companions... they need a home. Please help them find their way back...")

func complete_task(task_id: String):
	"""Mark a task as completed"""
	if task_id in tasks and not tasks[task_id]["completed"]:
		tasks[task_id]["completed"] = true
		task_completed.emit(tasks[task_id]["name"])

func place_food(animal_name: String):
	"""Record that food has been placed for an animal"""
	food_placed[animal_name] = true
	
	# Complete the associated task
	var task_map = {
		"jasper": "milk_for_jasper",
		"mary": "seeds_for_mary",
		"chester": "parsley_for_chester"
	}
	if animal_name in task_map:
		complete_task(task_map[animal_name])

func find_animal(animal_name: String):
	"""Mark an animal as found"""
	if animal_name not in found_animals:
		found_animals.append(animal_name)
		animal_found.emit(ANIMALS.get(animal_name, animal_name))
		
		# Check win condition
		check_win_condition()
		
		# Show ghost message
		var messages = {
			"jasper": "Jasper has returned! Thank you, kind child...",
			"mary": "Mary is safe! My heart feels lighter...",
			"chester": "Chester is home! You have done well..."
		}
		if animal_name in messages:
			show_ghost_message(messages[animal_name])

func check_win_condition():
	"""Check if all animals have been found"""
	if found_animals.size() >= 3:
		win_game()

func win_game():
	"""Trigger the win condition"""
	game_won.emit()
	show_ghost_message("All my beloved companions are safe... Thank you, dear child. Now I can finally rest in peace. May you and my friends find happiness together...")

func show_ghost_message(message: String):
	"""Display a ghost message"""
	ghost_message.emit(message)

func get_animals_found() -> int:
	"""Get the number of animals found"""
	return found_animals.size()

func get_total_animals() -> int:
	"""Get the total number of animals to find"""
	return ANIMALS.size()

func get_discovered_tasks() -> Array:
	"""Get all discovered tasks"""
	var result = []
	for task_id in tasks:
		if tasks[task_id]["discovered"]:
			result.append(tasks[task_id])
	return result

func is_task_completed(task_id: String) -> bool:
	"""Check if a task is completed"""
	if task_id in tasks:
		return tasks[task_id]["completed"]
	return false

