extends Area2D
class_name Selectable

export var selected : = false setget set_selected

func _ready():
	self.add_to_group("selectables")

func set_selected(value : bool):
	selected = value
	if selected:
		$Sprite.material = SelectionManager.highlight_material
		z_index = 1
		self.add_to_group("selected")
		on_selected()
	else:
		z_index = 0
		self.remove_from_group("selected")
		$Sprite.material = null
		on_deselected()

func on_selected():
	return
func on_deselected():
	return

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		SelectionManager.request_select(self)
