extends Node

@onready var main_camera = $MainCamera
var camera_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = main_camera.global_position
	current_position.x += camera_speed * delta
	main_camera.global_position = current_position
