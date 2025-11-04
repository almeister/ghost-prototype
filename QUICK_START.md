# Quick Start Guide

## Running the Game

1. **Open Godot 4.5.1+**
2. **Import Project**: Select the `ghost-prototype` folder
3. **Press F5** or click the ▶ Play button
4. **Start playing!**

## Basic Controls

**Keyboard:**
- Move: Arrow Keys or WASD
- Interact: E
- Logbook: Tab

**Controller:**
- Move: Left Stick or D-Pad
- Interact: A Button
- Logbook: Select Button

## Quick Gameplay Overview

1. **Explore the house** - Move through 5 rooms
2. **Find objects** - They highlight yellow when you're near
3. **Press E/A** to examine objects
4. **Check your logbook** (Tab/Select) to see tasks
5. **Find and place food** for the three animals:
   - **Milk** for Jasper the cat (kitchen area)
   - **Sunflower seeds** for Mary the bird (bedroom area)
   - **Parsley** for Chester the rabbit (bathroom area)
6. **Win** when all three animals are reunited!

## Clue Chains (Hints)

### For Jasper:
Book → Frog Figurine → Milk Note → Place Milk

### For Mary:
Coffee Mug → Bird Feeder → Seeds Note → Place Seeds

### For Chester:
Child's Drawing → Garden Photo → Parsley Note → Place Parsley

## Troubleshooting

**Can't interact with objects?**
- Make sure you're close enough (yellow highlight should appear)
- Try pressing E (keyboard) or A button (controller)

**Stuck in a UI menu?**
- Press E/A or Tab/Select to close

**Animal not appearing after placing food?**
- Wait 2 seconds after placing food
- Make sure you placed the correct food

**Can't find an object?**
- Check all 5 rooms systematically
- Objects are colored rectangles of various colors
- Use your flashlight to explore dark areas

## Tips for Students

1. **Read everything** - Clues contain important information
2. **Take notes** - The logbook helps, but your own notes help more
3. **Explore systematically** - Check every room
4. **Don't ignore red herrings** - They're fun and add atmosphere!
5. **Experiment** - Try interacting with everything

## Room Layout

```
┌─────────────┬──────────┐
│   Living    │ Kitchen  │
│    Room     │          │
├──────┬──────┼──────────┤
│ Bed- │Bath- │Basement  │
│ room │ room │          │
└──────┴──────┴──────────┘
```

## For Educators

This prototype demonstrates:
- ✅ Singleton pattern (GameManager, InputManager)
- ✅ Signal-based communication
- ✅ Scene inheritance
- ✅ Object-oriented design
- ✅ State management
- ✅ UI systems
- ✅ Input abstraction
- ✅ Environmental storytelling

See `STUDENT_GUIDE.md` for detailed educational content.

## Next Steps

After playing:
1. Check `TESTING_GUIDE.md` for systematic testing
2. Read `STUDENT_GUIDE.md` for code explanations
3. Open the scenes in Godot to see structure
4. Try modifying values in the editor
5. Experiment with creating new objects

Enjoy the game! 👻🔦
