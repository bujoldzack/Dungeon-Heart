extends Node

@onready var main_camera = $MainCamera
@onready var MainMenu = $MainCamera/Menu/MainMenu
@onready var OptionMenu = $MainCamera/Menu/OptionMenu
var camera_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = main_camera.global_position
	current_position.x += camera_speed * delta
	main_camera.global_position = current_position

func _on_options_button_pressed():
	MainMenu.visible = false
	OptionMenu.visible = true

#func _on_back_button_m_pressed():
	#MainMenu.visible = true
	#OptionMenu.visible = false

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
