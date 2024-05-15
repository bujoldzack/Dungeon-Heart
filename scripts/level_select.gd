extends Node2D

@onready var level_1_score = $VBoxContainer/ScoreLabel1
@onready var level_2_score = $VBoxContainer2/ScoreLabel2
@onready var level_3_score = $VBoxContainer3/ScoreLabel3
@onready var level_2_button = $VBoxContainer2/Level2
@onready var level_3_button = $VBoxContainer3/Level3
@onready var lock_label_1 = $LockLabel
@onready var lock_label_2 = $LockLabel2


# Called when the node enters the scene tree for the first time.
func _ready():
	SaveSystem.load_game_data_bytes()
	Global.high_score_1 = SaveSystem.save_dict.highscore_1
	Global.high_score_2 = SaveSystem.save_dict.highscore_2
	Global.high_score_3 = SaveSystem.save_dict.highscore_3
	
	level_1_score.text = "High Score: " + str(Global.high_score_1)
	level_2_score.text = "High Score: " + str(Global.high_score_2)
	level_3_score.text = "High Score: " + str(Global.high_score_3)
	
	if Global.high_score_1 < 100:
		level_2_button.disabled = true 
		lock_label_1.text = "Score 100 points in level 1 to unlock this level."
	if Global.high_score_2 < 200:
		level_3_button.disabled = true 
		lock_label_2.text = "Score 200 points in level 2 to unlock this level."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")
