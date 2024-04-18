extends Node2D

@onready var slime_spawner = $SlimeSpawner
var enemy_slime = preload("res://scenes/slime_enemy.tscn")
@onready var slime = $Slime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_slime_spawner_timeout():
	pass
