extends Hideable

const constructs_path = "res://scenes/constructs/"
onready var item_list = $CanvasLayer/ItemList
onready var cursor_tracker = preload("res://scenes/CursorTracker.tscn")
onready var build_target = preload("res://scenes/BuildTarget.tscn")

var construct_instances = []
var placing_id : = -1
var hologram : Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var filenames = get_filenames(constructs_path)
	for filename in filenames:
		if not filename.ends_with("tscn"):
			continue
		var construct = load(constructs_path + filename).instance(0)
		construct.position = Vector2(0,0)
		construct_instances.append(construct)
		var sprite = construct.get_node("Sprite")
		item_list.add_item(construct.variant_name, sprite.texture)
#		construct.free()

func get_filenames(path):
	var names = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			if not dir.current_is_dir():
				names.append(filename)
			filename = dir.get_next()
	return names

func on_hide():
	item_list.unselect_all()
	if is_instance_valid(hologram):
		hologram.free()

func _on_ItemList_item_selected(index):
#	print("Selected menu item: " + item_list.get_item_text(index))
	placing_id = index
	hologram = cursor_tracker.instance(PackedScene.GEN_EDIT_STATE_INSTANCE)
	hologram.add_child(construct_instances[index].get_node("Sprite").duplicate())
	get_tree().get_root().add_child(hologram)

func cancel_placement():
	if is_instance_valid(hologram):
		hologram.free()
	placing_id = -1
	item_list.unselect_all()

func order_construct(at_position):
	var cell = Terrain.tilemap.world_to_map(at_position)
	var tile = Terrain.tilemap.get_cell(cell.x, cell.y)
	var tileset = Terrain.tilemap.tile_set
	# is the tile default
	if tile == tileset.find_tile_by_name("default"):
		var target = build_target.instance()
		get_tree().get_root().add_child(target)
		target.position = Terrain.tilemap.map_to_world(cell) + Terrain.tilemap.cell_size/2
		# refactor this mess
		var bots = get_tree().get_root().get_node("/root/SceneRoot/Bots").bots
		for bot in bots:
			if bot.selected:
				bot.build_construct(construct_instances[placing_id], target)
				break

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		cancel_placement()
	if event is InputEventMouseButton and event.pressed:
		if placing_id == -1:
			return
		if event.button_index == BUTTON_RIGHT:
			cancel_placement()
		if not event.button_index == BUTTON_LEFT:
			return
		order_construct(get_global_mouse_position())
		cancel_placement()
