extends Node

# Annoyance counts the times Jeff was clicked.
# It's mainly for the beginning and has three main states:
# 0 = waiting, 1 = swaying, 2+ = start
# TODO use this for achievements or let Jeff say special things.
var annoyance = 0
var textdone = false
var shutup = false
var isonmobile

func _ready():
	isonmobile = testmobile()

func testmobile():
	var system = OS.get_name() 
	match system:
		"Android", "BlackBerry 10", "iOS": 
			return true
	return false
