extends BotTask

var construct: Construct
var target: Node2D
var elapsed : = 0.0
onready var base_tile = Terrain.tilemap.tile_set.find_tile_by_name("construct_base")
	
func _on_start():
	var cell = Terrain.tilemap.world_to_map(target.position)
	Terrain.tilemap.set_cell(cell.x, cell.y, base_tile)

func _process(delta):
	elapsed += delta
	if elapsed > duration:
		var clone = construct.duplicate()
		get_tree().get_root().add_child(clone)
		clone.position = target.position
		emit_signal("finished")
		target.free()
		self.free()
