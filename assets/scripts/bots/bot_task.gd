extends Node
class_name BotTask

onready var bot = get_parent()
var duration = 1

signal finished

func _ready():
	set_process(false)

func start():
	set_process(true)
	_on_start()
	
func _on_start():
	return
