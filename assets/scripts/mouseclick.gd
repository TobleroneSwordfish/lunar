extends Node2D

onready var bots = get_children() 

func _unhandled_input(event):
	if not event is InputEventMouseButton or not event.pressed:
		return
	if event.button_index == BUTTON_RIGHT:
		for bot in bots:
			if not bot.selected:
				continue
			bot.move(get_global_mouse_position())
