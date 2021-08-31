extends Processor

func _init():
	self.recipe = Recipe.new([["Thingy", 0.1]], [["Stuff", 0.1]])
	self.variant_name = "Test processor"
	
func _ready():
	$Input.delta(100)

func get_info():
	return {"Thingy" : [$Input.value, $Input, "value_changed"],\
		"Stuff" : [$Output.value, $Output, "value_changed"]}
