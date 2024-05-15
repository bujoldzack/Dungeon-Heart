extends CanvasLayer

@onready var dead_screen = $"."
@onready var score_label = $"ColorRect/VBoxContainer/HBoxContainer/Score Variable Label"
@onready var highest_score_label = $"ColorRect/VBoxContainer/HBoxContainer2/HScore Variable Label"

func _ready():
	pass

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
			SaveSystem.update_highscore_1(Global.high_score_1)
			SaveSystem.save_game_data_bytes()
			
	elif Global.level == 2:
		highest_score_label.text = str(Global.high_score_2)
		if Global.score > Global.high_score_2:
			Global.high_score_2 = Global.score
			SaveSystem.update_highscore_2(Global.high_score_2)
			SaveSystem.save_game_data_bytes()
	elif Global.level == 3:
		highest_score_label.text = str(Global.high_score_3)
		if Global.score > Global.high_score_3:
			Global.high_score_3 = Global.score
			SaveSystem.update_highscore_3(Global.high_score_3)
			SaveSystem.save_game_data_bytes()

func _reload_scene():
	var scene = get_tree().current_scene
	get_tree().reload_current_scene()

func _on_restart_button_pressed():
	Global.dead = false
	get_tree().paused = false
	_reload_scene()

func _on_back_button_pressed():
	Global.dead = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
