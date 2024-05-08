extends CanvasLayer

@onready var dead_screen = $"."

func _process(_delta):
	if Global.dead == true:
		dead_screen.visible = true
	else:
		dead_screen.visible = false

func _reload_scene():
	var scene = get_tree().current_scene
	get_tree().reload_current_scene()

func _on_restart_button_pressed():
	Global.dead = false
	get_tree().paused = false
	_reload_scene()

func _on_back_button_pressed():
	pass # Replace with function body.
