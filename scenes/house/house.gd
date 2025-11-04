extends Node2D

## House scene script
## Contains the layout and manages object placement

@onready var objects_container = $Objects

func _ready():
	pass

func add_object(object: Node2D, position: Vector2):
	"""Add an interactable object to the house"""
	object.position = position
	objects_container.add_child(object)

func get_room_center(room_name: String) -> Vector2:
	"""Get the center position of a room"""
	var room_centers = {
		"living_room": Vector2(300, 250),
		"kitchen": Vector2(650, 250),
		"bedroom": Vector2(250, 550),
		"bathroom": Vector2(500, 550),
		"basement": Vector2(700, 550)
	}
	return room_centers.get(room_name, Vector2.ZERO)

