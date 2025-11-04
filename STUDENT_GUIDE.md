# Student Guide - Ghost Detective Prototype

## Learning Objectives

This prototype demonstrates professional game development practices in Godot. Here's what you can learn:

## 1. Project Architecture

### Singleton Pattern (Autoloads)
**Files**: `scripts/singletons/InputManager.gd`, `scripts/singletons/GameManager.gd`

**What it does**: Creates globally accessible managers that persist across scenes.

**Why it matters**: 
- Centralized state management
- No need to pass references between scenes
- Single source of truth for game state

**Key Code**:
```gdscript
# In GameManager.gd
signal task_discovered(task_name: String)
var found_animals: Array[String] = []

# From anywhere in the game:
GameManager.find_animal("jasper")
```

### Scene Inheritance
**Files**: `scenes/objects/*.tscn`

**What it does**: Child scenes inherit from base scenes and override properties.

**Example**: All clue objects inherit from `InteractableObject.tscn` but have different names, descriptions, and colors.

## 2. Input System

### Multi-Input Support
**File**: `scripts/singletons/InputManager.gd`

**Handles**: Keyboard, controller, and joystick inputs simultaneously

**Key Concepts**:
```gdscript
# Abstract input checking
func get_movement_vector() -> Vector2:
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_axis("move_left", "move_right")
    input_vector.y = Input.get_axis("move_up", "move_down")
    return input_vector.normalized()
```

**Why it matters**: Players can switch between keyboard and controller seamlessly.

## 3. Signal-Based Communication

### Observer Pattern
**Files**: Multiple files use signals

**Example Flow**:
1. Player interacts with task object
2. Object calls `GameManager.discover_task()`
3. GameManager emits `task_discovered` signal
4. Logbook listens to signal and updates UI

**Key Code**:
```gdscript
# GameManager.gd
signal task_discovered(task_name: String)
task_discovered.emit(tasks[task_id]["name"])

# logbook.gd
func _ready():
    GameManager.task_discovered.connect(_on_task_discovered)
```

**Why it matters**: Loose coupling - systems don't need to know about each other directly.

## 4. State Management

### Tracking Game Progress
**File**: `scripts/singletons/GameManager.gd`

**Manages**:
- Discovered objects
- Completed tasks
- Found animals
- Win condition

**Key Concepts**:
```gdscript
var tasks: Dictionary = {
    "milk_for_jasper": {
        "name": "Leave milk for Jasper",
        "completed": false,
        "discovered": false
    }
}
```

## 5. UI Systems

### Three UI Patterns

**1. Modal Popup (ObjectViewer)**
- Blocks player movement
- Displays detailed information
- Player must dismiss to continue

**2. Toggle Panel (Logbook)**
- Opens/closes with button press
- Pauses gameplay
- Shows persistent state

**3. Timed Notification (GhostMessage)**
- Appears automatically
- Queues multiple messages
- Dismisses on interaction

## 6. Interaction System

### Detection & Highlighting
**File**: `scenes/player/player.gd`

**How it works**:
1. Player has an `InteractionArea` (Area2D)
2. Objects are on the "interactable" collision layer
3. When objects enter the area, they're added to `nearby_interactables`
4. Objects are highlighted when nearby
5. Pressing interact triggers the closest object

## 7. Clue Chain Design

### Environmental Storytelling

**Design Pattern**: Each animal has a discovery chain

```
Clue 1 (Broad) → Clue 2 (Specific) → Task → Action → Reward
```

**Example - Jasper**:
```
Book about frogs → Frog figurine → Note about milk → Place milk → Jasper appears
```

**Why this works**:
- Creates sense of discovery
- Rewards exploration
- Feels like puzzle-solving
- Natural progression

## 8. Object-Oriented Design

### Class Hierarchy

```
Node2D
├── Area2D (Base for interaction)
    ├── InteractableObject (Base class)
    │   ├── Clue objects
    │   ├── Task objects
    │   └── Red herring objects
    ├── Animal (Separate class for animals)
    └── FoodItem (Separate class for food)
```

**Why separate classes**:
- Different behaviors
- Animals appear dynamically
- Food items trigger events
- Keeps code focused and maintainable

## 9. Visual Feedback Systems

### Player Feedback Loops

Every player action gets feedback:
- **Approach object** → Yellow highlight
- **Interact** → Popup appears
- **Place food** → Ghost message
- **Animal appears** → Animation + message
- **Task completed** → Checkmark in logbook

**Why it matters**: Players always know their actions have effect.

## 10. Lighting & Atmosphere

### Dual Lighting System
**Files**: `scenes/player/Player.tscn`, `scenes/Main.tscn`

**Components**:
1. `CanvasModulate` - Global darkness (10% brightness)
2. `PointLight2D` - Player's flashlight

**Effect**: Creates limited visibility and spooky atmosphere

## Code Quality Practices

### 1. Documentation
Every script has:
- Class-level comments (`##`)
- Function documentation
- Clear variable names

### 2. Type Hints
```gdscript
var found_animals: Array[String] = []
func discover_task(task_id: String) -> void:
```

### 3. Export Variables
```gdscript
@export var speed: float = 200.0
@export_multiline var description: String = ""
```
Makes values editable in the Godot editor without touching code.

### 4. Onready Variables
```gdscript
@onready var sprite: ColorRect = $Sprite
```
Automatically assigned when scene loads.

## Game Design Lessons

### 1. Red Herrings
Not everything needs to be useful! Red herrings:
- Add personality
- Prevent linearity
- Make discovery feel earned
- Provide humor/atmosphere

### 2. Progressive Discovery
- Start simple (find book)
- Build complexity (connect clues)
- Reward thoroughness (all animals)

### 3. Multiple Solution Paths
Players can find animals in any order - no forced sequence.

## Common Godot Patterns Used

### 1. Groups
```gdscript
add_to_group("player")
add_to_group("animals")

# Later:
var player = get_tree().get_first_node_in_group("player")
```

### 2. Call Deferred
```gdscript
call_deferred("find_player")
```
Waits until scene tree is fully ready.

### 3. Tweens
```gdscript
var tween = create_tween()
tween.tween_property(self, "scale", Vector2.ONE, 0.5)
```
Simple animations without AnimationPlayer.

### 4. Await
```gdscript
await get_tree().create_timer(2.0).timeout
```
Wait for time without blocking the game.

## Extending This Prototype

### Easy Additions:
1. **More rooms** - Add to House.tscn
2. **More objects** - Duplicate and modify existing objects
3. **More animals** - Follow the same pattern
4. **Sound effects** - Add AudioStreamPlayer nodes
5. **Better graphics** - Replace ColorRect with Sprite2D

### Medium Additions:
1. **Save/load system** - Use `FileAccess` to write JSON
2. **Dialogue system** - Create choice-based interactions
3. **Inventory system** - Track collected items
4. **Mini-games** - Add interaction challenges

### Advanced Additions:
1. **Procedural generation** - Random room layouts
2. **Multiple ghosts** - Different stories
3. **Skill system** - Unlock abilities
4. **Multiplayer** - Co-op exploration

## Discussion Questions

1. **Why use signals instead of direct function calls?**
   - Decoupling, flexibility, maintainability

2. **Why separate InputManager from Player?**
   - Reusability, testing, multiple control schemes

3. **Why use a Dictionary for tasks instead of individual variables?**
   - Scalability, data-driven design, easier to modify

4. **Why are red herrings valuable?**
   - Prevent linear gameplay, add personality, realistic environment

5. **How does the clue chain design guide player behavior?**
   - Progressive revelation, spatial exploration, pattern recognition

## Files to Study in Order

1. **Start**: `scripts/singletons/InputManager.gd` - Simple, clear example
2. **Then**: `scenes/player/player.gd` - Input usage, interaction system
3. **Next**: `scripts/singletons/GameManager.gd` - State management, signals
4. **After**: `scenes/objects/interactable_object.gd` - Base class design
5. **Then**: `scenes/ui/object_viewer.gd` - UI pattern
6. **Finally**: `scenes/main.gd` - Putting it all together

## Exercises

### Beginner:
1. Add a new red herring object
2. Change the flashlight color
3. Add a new room to the house

### Intermediate:
1. Create a fourth animal with its own clue chain
2. Add a timer to the game
3. Create a hint system

### Advanced:
1. Implement a save/load system
2. Create a dialogue tree for the ghost
3. Add a puzzle that must be solved to access a room

## Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Godot Signals Tutorial](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)

## Questions?

When studying this code, ask yourself:
- **What** does this code do?
- **Why** is it structured this way?
- **How** could I modify it?
- **What** would happen if I changed X?

The best way to learn is to experiment! Make changes, break things, fix them, and understand why they broke.

Good luck, and have fun exploring game development! 👻🎮

