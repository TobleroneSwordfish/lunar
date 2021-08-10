extends Label

class_name LiveLabel

func register(node, signal_name):
	node.connect(signal_name, self, "_update")
	
func _update(value):
	if value is float:
		value = stepify(value, 0.01)
	text = str(value)
