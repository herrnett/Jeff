extends Area2D


### Variables ###
# Initially Jeff Skullington 
# waits to be clicked (tracked by annoyance in GlobalVariables.gd)
# while blinking at random intervals (stored in blinkwait) and
# starts swaying when clicked (his current velocity is stored in sway).
var blinkwait = rand_range(1, 3)
var swaypower = 25


### Functions ###
# Check if event is a click.
# If it is, Jeff stops waiting with a blink.
# On the second click he becomes bigger and moves to the center of the screen.
# On the third click he stops and stares.
# On the fourth and subsequent clicks he starts talking.
# IDEA after a certain amount of clicks he'll stop for a while
# and needs a few more blinky clicks to resume, maybe saying something impolite
func _on_Jeff_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		Globals.annoyance += 1
		print(Globals.annoyance)
		blink()
		if Globals.annoyance == 2:
			moveresize(
				Vector2(get_viewport().get_visible_rect().size.x/2, get_viewport().get_visible_rect().size.y/2.8), 
				Vector2(2, 2))
		if Globals.annoyance > 3 and !Globals.shutup: 
			talk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Decreases Jeffs blink counter and blinks when it's time to blink.
# He will sway after he first gets touched until he has had enough (two touches).
func _process(delta):
	blinkwait -= delta
	if blinkwait < 0: blink()
	if Globals.annoyance != 0 and Globals.annoyance < 3: sway(delta)

# Uses two vectors two move and resize Jeff.
func moveresize(target, resize):
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self, "position", position, target, 3, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.interpolate_property(self, "scale", scale, resize, 3, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()

# This is how Jeff sways.
func sway(delta):
	rotation_degrees += swaypower*delta
	swaypower += delta*25 if rotation_degrees < 0 else -delta*25

# This is how Jeff blinks. He only does it when he isn't talking.
func blink():
	$JeffFace.set_frame(0)
	$JeffFace.play("blink")
	blinkwait = rand_range(3, 8)
	
# This is how Jeff talks. This was more complex before.
func talk():
	if !Globals.shutup:
		$JeffFace.set_frame(0)
		$JeffFace.play("talk")

# Sets Jeff back into idle-mode after he is done talking.
func _on_JeffFace_animation_finished():
	if Globals.textdone: $JeffFace.play("idle")
