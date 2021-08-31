extends Construct
class_name Processor

var _input_containers = []
var _output_containers = []
var recipe : Recipe = null


func _init():
	variant_name = "Generic processor"

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		if child is ResourceContainer:
			if child.is_input:
				_input_containers.append(child)
			if child.is_output:
				_output_containers.append(child)
				
# this function does possibly too much work, too bad

# check if a given resource_list is satisfied by the container_list, depending on whether it is input or output
# is_input = false assumes output
# execute determines whether to actually take or add the resource
func _parse_containers(resource_list, container_list, is_input : bool, execute : bool = false):
	for resource in resource_list:
		var satisfied = false
		for container in container_list:
			if container.resource_type == resource[0]:
				if is_input and container.value > resource[1]:
					# found container that can satisfy this input
					satisfied = true
					if execute:
						container.delta(-resource[1])
					break
				if not is_input and container.get_space() > resource[1]:
					# found container that can satisfy this output
					satisfied = true
					if execute:
						container.delta(resource[1])
					break
		if not satisfied:
			return false
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if recipe == null:
		return
	# check we have sufficient input resources
	if not _parse_containers(recipe.inputs, _input_containers, true):
		return
	# check we have sufficient space to output
	if not _parse_containers(recipe.outputs, _output_containers, false):
		return	
	# perform the process
	_parse_containers(recipe.inputs, _input_containers, true, true)
	_parse_containers(recipe.outputs, _output_containers, false, true)
