extends Processor
class_name SolidElectrolyzer

func _init():
	self.recipe = Recipe.new([["Regolith", 0.1]], [["Oxygen", 0.05], ["Slag", 0.05]])
	self.variant_name = "Solid Electrolyzer"
	
# add some regolith to the input hopper to test
#TODO delet this
func _ready():
	$Input.delta(100)

func get_info():
	return {"Regolith" : [$Input.value, $Input, "value_changed"],\
		"Oxygen" : [$Output1.value, $Output1, "value_changed"],\
		"Slag" : [$Output2.value, $Output2, "value_changed"]}
