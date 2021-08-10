extends Hideable

onready var vbox = $CanvasLayer/Control/PanelContainer/VBoxContainer
onready var variant_label = vbox.get_node("ConstructVariant")
onready var _live_label = preload("res://scenes/LiveLabel.tscn")

var describing : Node

# the dreaded ui megafunction
func describe(info : Dictionary, node : Node):
	describing = node
	# delete old labels
	get_tree().call_group("info_ui_labels", "free")
	# generate new ones
	for key in info.keys():
		var value
		# each value in the dictionary is either a single static value
		# or an array of [value, node, signal_name]
		if info[key] is Array:
			value = info[key][0]
		else:
			value = info[key]
		# round it if needed
		if value is float:
			value = stepify(value, 0.01)
		var value_label = _live_label.instance()
		value_label.text = str(value)
		# register the signal to update the live label
		if info[key] is Array:
			value_label.register(info[key][1], info[key][2])
		# build ui structure, could do this with a scene
		var row = HBoxContainer.new()
		vbox.add_child(row)
		var key_label = Label.new()
		key_label.text = str(key) + ": "
		row.add_child(key_label)
		row.add_child(value_label)
		row.add_to_group("info_ui_labels")
