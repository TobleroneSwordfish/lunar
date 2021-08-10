extends Selectable
class_name Bot

onready var build_task = preload("res://scenes/BuildConstructTask.tscn")

export var speed : = 128.0
var path : = PoolVector2Array() setget set_path

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

func on_selected():
	ConstructMenu.show()
func on_deselected():
	ConstructMenu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)

func move_along_path(distance: float):
	var start_point = position
	for i in range(path.size()):
		var dist_to_next = start_point.distance_to(path[0])
		if distance <= dist_to_next and distance >= 0:
			position = start_point.linear_interpolate(path[0], distance/dist_to_next)
			break
		elif distance < 0:
			position = path[0]
			set_process(false)
			destination_reached()
		distance -= dist_to_next
		start_point = path[0]
		path.remove(0)
		if len(path) == 0:
			set_process(false)
			destination_reached()

func destination_reached():
	for node in get_children():
		if node is BotTask:
			node.start()

# this throws a compile error, but still works, because GDScript is fine
func build_construct(construct: Construct, target: Node2D):
	var task = build_task.instance()
	task.construct = construct
	task.target = target
	self.add_child(task)
	move(target.position)
	
func move(destination):
	var new_path = Terrain.nav.get_simple_path(global_position, destination)
#	bot.get_node("Line2D").points = new_path
	set_path(new_path)
	
func set_path(value : PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
