extends Selectable
class_name Construct

var variant_name = "Generic construct"

func _ready():
	add_to_group("constructs")

func on_selected():
	if not InfoUI.hidden and InfoUI.describing == self:
		return
	InfoUI.variant_label.text = variant_name
	InfoUI.show()
	InfoUI.describe(self.get_info(), self)
func on_deselected():
	InfoUI.clear()
	InfoUI.hide()

# should return a dict of info about the construct
func get_info():
	return {}
