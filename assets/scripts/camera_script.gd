extends Camera2D

export var move_speed = 64
export var zoom_rate = 0.1
export var zoom_min = 0.1
export var zoom_max = 2

var screen_size

var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current = true
	screen_size = get_viewport_rect().size

func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		# zoom controls
		if event.button_index == BUTTON_WHEEL_UP and zoom.y > zoom_min:
			zoom *= (1 - zoom_rate)
		if event.button_index == BUTTON_WHEEL_DOWN and zoom.x < zoom_max:
			zoom *= (1 + zoom_rate)
		# camera dragging state
		if event.button_index == BUTTON_LEFT and Input.is_action_pressed("camera_pan"):
			get_tree().set_input_as_handled();
			dragging = event.is_pressed()
	elif event is InputEventMouseMotion and dragging:
		position -= event.relative * zoom.x
