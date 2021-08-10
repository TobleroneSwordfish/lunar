extends Node2D
class_name Hideable

# hacky way of completely hiding nodes by removing them from the scene tree
# works great

var _root
var hidden = false

var initial_hide = true
func _process(delta):
	if initial_hide:
		initial_hide = false
		hide()

func _ready():
	_root = get_tree().get_root()
	
func show():
	_root.add_child(self)
	hidden = false
	on_show()
	
func hide():
	_root.remove_child(self)
	hidden = true
	on_hide()

func on_show():
	return
func on_hide():
	return
