# Testing Guide - Ghost Detective Prototype

This guide helps you test all the features of the game systematically.

## Pre-Test Checklist

1. ✅ Open the project in Godot 4.5.1 or later
2. ✅ Ensure your controller is connected (if testing controller input)
3. ✅ Press F5 or click Play to start the game

## Test 1: Basic Controls

### Keyboard
- [ ] Move up with W or Up Arrow
- [ ] Move down with S or Down Arrow
- [ ] Move left with A or Left Arrow
- [ ] Move right with D or Right Arrow
- [ ] Confirm 8-directional movement works (diagonal movement)

### Controller
- [ ] Move with left joystick in all 8 directions
- [ ] Move with D-Pad in all 4 cardinal directions
- [ ] Confirm smooth movement response

## Test 2: Visual Systems

### Flashlight
- [ ] Confirm the player has a visible light radius
- [ ] Confirm areas outside the flashlight are dark
- [ ] Confirm the flashlight follows the player
- [ ] Notice subtle flicker effect (optional)

### Player
- [ ] Player is visible (blue colored rectangle)
- [ ] Direction indicator (white rectangle) rotates with movement
- [ ] Camera follows the player smoothly

## Test 3: Interaction System

### Finding Objects
- [ ] Move close to an object (colored rectangle)
- [ ] Confirm yellow highlight appears when near an object
- [ ] Press E (or A button) to interact
- [ ] ObjectViewer popup appears with object details
- [ ] Press E (or A button) again to close the viewer
- [ ] Confirm player cannot move while viewing object

### Test Each Room
**Living Room** (brown floor):
- [ ] Ancient Book (brown) - clue about frogs
- [ ] Frog Figurine (green) - clue about milk
- [ ] Old Bill (beige) - red herring
- [ ] Family Photo (light gray) - red herring

**Kitchen** (tan floor):
- [ ] Milk Note (yellow) - task object
- [ ] Coffee Mug (brown) - clue about Mary
- [ ] Pizza Menu (red) - red herring

**Basement** (dark blue floor):
- [ ] Bird Feeder (tan) - clue about seeds
- [ ] Seeds Note (light blue) - task object

**Bedroom** (purple floor):
- [ ] Child's Drawing (pink) - clue about Chester
- [ ] Creepy Diary (dark brown) - red herring

**Bathroom** (cyan floor):
- [ ] Garden Photo (gray) - clue about parsley
- [ ] Parsley Note (green) - task object

## Test 4: Logbook System

- [ ] Press Tab (or Select button)
- [ ] Logbook opens
- [ ] Before discovering tasks, see "No tasks discovered yet" message
- [ ] Interact with a task object (Milk Note, Seeds Note, or Parsley Note)
- [ ] Open Logbook again
- [ ] Confirm task appears in the list with [ ] checkbox
- [ ] Confirm "Animals Found: 0 / 3" displays
- [ ] Press Tab (or Select) to close
- [ ] Confirm player can move again

## Test 5: Ghost Narrative

### Initial Message
- [ ] Game starts with ghost message at bottom of screen
- [ ] Message reads: "Welcome, child... This house holds memories..."
- [ ] Press E (or A) to dismiss

### Clue Discovery Message
- [ ] Interact with any clue or task object
- [ ] Ghost message appears about beloved companions
- [ ] Dismiss message

## Test 6: Food Placement & Animal Discovery

### Test Jasper (Cat)
1. [ ] Find and read Milk Note in kitchen
2. [ ] Open Logbook - confirm "Leave milk for Jasper" task appears
3. [ ] Find the white milk saucer near the kitchen (right side)
4. [ ] Interact with milk saucer (E or A button)
5. [ ] Ghost message: "The food has been placed. Now we wait..."
6. [ ] Wait 2 seconds
7. [ ] Jasper (black rectangle) appears in the kitchen area
8. [ ] Ghost message: "Jasper has returned! Thank you..."
9. [ ] Interact with Jasper to see his description
10. [ ] Open Logbook - confirm task has [✓] checkmark
11. [ ] Confirm "Animals Found: 1 / 3"

### Test Mary (Bird)
1. [ ] Find and read Seeds Note
2. [ ] Find sunflower seeds (yellow-tan dish) near bedroom
3. [ ] Interact with seeds
4. [ ] Wait 2 seconds
5. [ ] Mary (blue rectangle) appears near bedroom
6. [ ] Ghost message: "Mary is safe! My heart feels lighter..."
7. [ ] Interact with Mary
8. [ ] Check Logbook: "Animals Found: 2 / 3"

### Test Chester (Rabbit)
1. [ ] Find and read Parsley Note in bathroom
2. [ ] Find fresh parsley (green) in bathroom area
3. [ ] Interact with parsley
4. [ ] Wait 2 seconds
5. [ ] Chester (white rectangle) appears in bathroom
6. [ ] Ghost message: "Chester is home! You have done well..."
7. [ ] Interact with Chester
8. [ ] Check Logbook: "Animals Found: 3 / 3"

## Test 7: Win Condition

After finding all three animals:
- [ ] Final ghost message appears
- [ ] Message reads: "All my beloved companions are safe... Thank you, dear child..."
- [ ] "Now I can finally rest in peace..."
- [ ] Check console output for "GAME WON!" message

## Test 8: Clue Chain Logic

### Jasper Chain
- [ ] Book mentions frogs → Find frog figurine → Note about milk → Place milk → Jasper appears

### Mary Chain
- [ ] Coffee mug shows Mary → Bird feeder → Seeds note → Place seeds → Mary appears

### Chester Chain
- [ ] Child's drawing → Garden photo → Parsley note → Place parsley → Chester appears

## Test 9: Red Herrings

Confirm these objects are interesting but don't contribute to animal tasks:
- [ ] Old electricity bill (humorous)
- [ ] Creepy diary (spooky)
- [ ] Pizza menu (comedic)
- [ ] Family photo (story background)

## Known Limitations (Prototype)

- Graphics are placeholder colored rectangles
- No sound effects or music
- No save/load system
- No animations (except animal appearance)
- Simple collision (may clip walls slightly)
- Food placement is one-time interaction (can't be moved after)

## Bug Reporting

If you find issues, note:
1. What were you doing?
2. What did you expect to happen?
3. What actually happened?
4. Can you reproduce it?

## Performance Check

- [ ] Game runs at 60 FPS on target device
- [ ] No stuttering during movement
- [ ] UI popups appear instantly
- [ ] No lag when interacting with objects

## Success Criteria

✅ All core mechanics work
✅ All three animals can be found
✅ Win condition triggers
✅ Both keyboard and controller inputs work
✅ UI systems function correctly
✅ Clue chains lead to solutions
✅ Ghost narrative appears at key moments

## Demonstration Tips

When showing this prototype to students:

1. **Start with controls** - Let them move around first
2. **Show interaction** - Demonstrate examining an object
3. **Explain clue types** - Show the difference between clues, tasks, and red herrings
4. **Walk through one chain** - Complete Jasper's quest together
5. **Let them explore** - Allow independent discovery of Mary and Chester
6. **Discuss design** - Talk about why certain decisions were made
7. **Show the code** - Demonstrate the singleton pattern, signals, etc.

This helps students understand both gameplay AND implementation!
