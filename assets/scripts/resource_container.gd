extends Node
class_name ResourceContainer

export var limit : = 100.0
var value : float setget set_value , get_value
export var resource_type : String
export var is_input : = false
export var is_output : = false

signal value_changed(new_value)

func get_space():
	return limit - value

# attempts to add amount to the tank, returns the amount that was actually added
# should work for negatives
func delta(amount):
	var old_value = value
	value = clamp(value + amount, 0, limit)
	var deposited = value - old_value
	if deposited != 0.0:
		emit_signal("value_changed", value)
	return value - old_value

# no fuck you
func set_value(_e):
	push_error("value property may not be modifed directly, use .delta()")
	assert(false)
func get_value():
	return value
