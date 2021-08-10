extends Construct
class_name FanExtractor

onready var container = $ResourceContainer
var peak_rate : = 10.0

func _init():
	variant_name = "Fan Extractor"

func _process(delta):
	container.delta(delta)

func get_info():
	return {"Regolith" : [container.value, container, "value_changed"],\
		"Regolith capacity" : container.limit}
