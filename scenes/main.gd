extends Node2D

## Main game scene script
## Handles game initialization and overall game flow

func _ready():
	# Connect to win signal
	GameManager.game_won.connect(_on_game_won)
	
	# Start the game
	GameManager.start_game()
	
	# Set up any additional initialization
	print("Ghost Detective Game Started!")
	print("Controls:")
	print("  Move: Arrow Keys / WASD / Controller Joystick")
	print("  Interact: E / Controller A Button")
	print("  Logbook: Tab / Controller Select")

func _on_game_won():
	"""Handle game win condition"""
	print("GAME WON! All animals have been reunited!")
	# Could add a win screen here in the future
