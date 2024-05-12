extends CanvasLayer

@onready var dead_screen = $"."
@onready var score_label = $"ColorRect/VBoxContainer/HBoxContainer/Score Variable Label"
@onready var highest_score_label = $"ColorRect/VBoxContainer/HBoxContainer2/HScore Variable Label"

func _process(_delta):
	if Global.dead == true:
		dead_screen.visible = true
	else:
		dead_screen.visible = false
	
	score_label.text = str(Global.score) 
	
	if Global.level == 1:
		highest_score_label.text = str(Global.high_score_1)
		if Global.score > Global.high_score_1:
			Global.high_score_1 = Global.score
	elif Global.level == 2:
		highest_score_label.text = str(Global.high_score_2)
		if Global.score > Global.high_score_2:
			Global.high_score_2 = Global.score
	elif Global.level == 3:
		highest_score_label.text = str(Global.high_score_3)
		if Global.score > Global.high_score_3:
			Global.high_score_3 = Global.score

func _reload_scene():
	var scene = get_tree().current_scene
	get_tree().reload_current_scene()

func _on_restart_button_pressed():
	Global.dead = false
	get_tree().paused = false
	_reload_scene()

func _on_back_button_pressed():
	pass # Replace with function body.
