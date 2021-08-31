extends Object
class_name Recipe

var inputs
var outputs

# both inputs and outputs should be lists of pairs of resource names and values
# so input = [["Water", 1.0]], output = [["Hydrogen", 2.0/3.0], ["Oxygen", 1.0/3.0]]
# would represent perfectly efficient elecrolysis of water
func _init(inputs, outputs):
	self.inputs = inputs
	self.outputs = outputs
