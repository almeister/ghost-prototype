extends PointLight2D

## Flashlight script for the player
## Creates the spotlight effect and manages lighting

@export var flicker_enabled: bool = true
@export var flicker_strength: float = 0.1
@export var flicker_speed: float = 10.0

var base_energy: float = 1.5
var time: float = 0.0

func _ready():
	base_energy = energy
	enabled = true

func _process(delta: float):
	if flicker_enabled:
		time += delta * flicker_speed
		# Create subtle flicker effect
		var flicker = sin(time) * flicker_strength
		energy = base_energy + flicker
