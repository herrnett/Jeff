# This Textbox will activate when Jeff is clicked.
# It'll then start/stop a timer which will make the text appear.
# If the all text has been written to screen, it set's a global
# variable (textdone) which is used by jeff to determine whether
# or not to play the talking-animation.

extends RichTextLabel

# Variables
var i = 0
var bbtextlayout = "[center][wave amp=50 freq=2][color=white]%s[/color][/wave][/center]"
var jefftext = [
	"Könntest du aufhören,\nmich anzufassen?",
	"Es stört.",
	"Bitte.",
	"Gut, dann eben\nnicht.",
	"Ich hoffe, das\nmacht dir Spaß.",
	"Mir nämlich nicht.",
	"Scheint dir\negal zu sein.",
	"...",
	"Cool.",
	"Ist aber schon etwas\nunhöflich, oder?",
	"Findest du wohl nicht.",
	"Okay.",
	"Ist ja nur\nmeine Meinung.",
	"Mach ruhig weiter.",
	"Wirst schon sehen,\nwas du davon hast.",
	"Eines Tages werd ich\nmich rächen.",
	"Ich werd die Herzen\naller Mädchen brechen.",
	"Dann bin ich ein Star,\nder in der Zeitung\nsteht.",
	"Und dann tut es dir\nleid, doch dann ist\nes zu spät."
]

# Called when the node enters the scene tree for the first time.
# Initially, no text should be seen, but the first text should be loaded.
func _ready():
	visible_characters = 0
	bbcode_text = bbtextlayout % jefftext[i]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Checks if Jeff was klicked. If he was, 
func _on_Jeff_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		if Globals.textdone and i < jefftext.size()-1:
			visible_characters = 0
			i += 1
			bbcode_text = bbtextlayout % jefftext[i]
			Globals.textdone = false
			if i == jefftext.size()-1:
				Globals.shutup = true
		else: 
			visible_characters = 0 
		if Globals.annoyance > 3 and Globals.textdone == false: 
			$Timer.start()
			if !Globals.isonmobile: $AudioStreamPlayer.play()
		else: 
			$Timer.stop()
			if !Globals.isonmobile: $AudioStreamPlayer.stop()


func _on_Timer_timeout():
	if !Globals.textdone:
		visible_characters += 1
		if visible_characters == text.length(): 
			if !Globals.isonmobile: $AudioStreamPlayer.stop()
			Globals.textdone = true
