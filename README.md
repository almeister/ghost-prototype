# Ghost Detective Prototype

A 2D mystery/detective game prototype built in Godot 4.5 for educational demonstration.

## Game Overview

You play as a brave child exploring a haunted house. A ghost communicates with you, seeking help to complete their unfinished business. The ghost was an animal shelter owner who lost their three beloved pets - Jasper the cat, Mary the bird, and Chester the rabbit. Help reunite them by discovering clues and completing tasks!

## Controls

### Keyboard (Backup)
- **Movement**: Arrow Keys or WASD
- **Interact**: E
- **Toggle Logbook**: Tab

### Controller (Primary) - Nintendo Switch or Similar
- **Movement**: Left Joystick or D-Pad
- **Interact**: A Button
- **Toggle Logbook**: Select Button

## Gameplay

### Core Mechanics

1. **Exploration**: Move through 5 rooms (Living Room, Kitchen, Bedroom, Bathroom, Basement)
2. **Flashlight**: You can only see within your flashlight's range - everything else is dark
3. **Interaction**: Approach objects and press the interact button to examine them
4. **Clue Discovery**: Find objects that point you to other locations and items
5. **Task Completion**: Discover what each animal needs and place their favorite food
6. **Animal Reunion**: When you place the correct food, the animal appears

### Object Types

- **Clues**: Objects that hint at other locations or items (e.g., a book mentioning frogs, a coffee mug with a bird drawing)
- **Tasks**: Notes and instructions telling you what to do (e.g., "Leave milk for Jasper")
- **Red Herrings**: Interesting but unrelated objects that add flavor and humor
- **Food Items**: Items you can interact with to place them and lure animals
- **Animals**: The three pets you're helping to reunite

### Clue Chains

**Finding Jasper (Cat)**
1. Read the ancient book about frogs
2. Find the frog figurine on the mantelpiece
3. Discover the note about milk
4. Place the milk saucer in the kitchen
5. Jasper appears!

**Finding Mary (Bird)**
1. Examine the coffee mug with Mary's name
2. Find the bird feeder in the basement
3. Discover the note about sunflower seeds
4. Place the seeds near the bedroom window
5. Mary appears!

**Finding Chester (Rabbit)**
1. Look at the child's drawing of a rabbit
2. Find the garden photograph
3. Discover the recipe card about parsley
4. Place the parsley in the bathroom
5. Chester appears!

### Winning the Game

Find all three animals to complete the ghost's unfinished business. The ghost will finally be at peace, and you'll have three new pets!

## Project Structure

```
ghost-prototype/
├── scenes/
│   ├── player/          # Player character and flashlight
│   ├── house/           # House layout with 5 rooms
│   ├── objects/         # All interactable objects, animals, and food
│   ├── ui/              # User interface (ObjectViewer, Logbook, GhostMessage)
│   └── Main.tscn        # Main game scene
├── scripts/
│   └── singletons/      # Global managers (InputManager, GameManager)
└── assets/
	└── sprites/         # Placeholder for sprite assets
```

## Technical Details

- **Engine**: Godot 4.5.1
- **Renderer**: Mobile
- **Perspective**: 2D Top-Down
- **Art Style**: Placeholder colored rectangles (for prototyping)
- **Input**: Controller-first with keyboard fallback

## Educational Notes

This prototype demonstrates:

1. **Game Architecture**: Singleton pattern for managers, scene inheritance, modular design
2. **Input Handling**: Multi-input support (keyboard + controller)
3. **State Management**: Tracking discovered objects, completed tasks, and found animals
4. **UI Systems**: Popup viewers, persistent logbooks, narrative messaging
5. **Game Feel**: Lighting effects, highlight feedback, smooth animations
6. **Narrative Design**: Environmental storytelling through discoverable clues
7. **Puzzle Design**: Interconnected clue chains leading to solutions

## Running the Game

1. Open the project in Godot 4.5.1 or later
2. Press F5 or click the Play button
3. Explore the house and interact with objects
4. Check your logbook (Tab) to track tasks
5. Find all three animals to win!

## Future Enhancements (Beyond Prototype)

- Replace placeholder sprites with proper artwork
- Add sound effects and background music
- Implement save/load system
- Add more rooms and objects
- Create additional puzzles and animals
- Add animations for player and animals
- Implement particle effects for atmosphere
- Add dialogue system with full ghost conversations

## License

This is an educational prototype for demonstration purposes.
