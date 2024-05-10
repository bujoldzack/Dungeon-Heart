extends Node2D

var enemy_slime = preload("res://scenes/slime_enemy.tscn")
var enemy_skeleton = preload("res://scenes/enemy_skeleton_base.tscn")
var enemy_golem = preload("res://scenes/golem_enemy.tscn")
var spawners = []
@onready var slime_spawner_timer = $SlimeSpawnerTimer
@onready var slimer_spawner_timer_2 = $SlimerSpawnerTimer2
@onready var skeleton_spawner_timer = $SkeletonSpawnerTimer
@onready var golem_spawner_timer = $GolemSpawnerTimer

func _ready():
	spawners = [$Spawners/Spawner1, $Spawners/Spawner2, $Spawners/Spawner3, $Spawners/Spawner4, $Spawners/Spawner5, $Spawners/Spawner6, $Spawners/Spawner7, $Spawners/Spawner8]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.score >= 100 && Global.score < 300 :
		slime_spawner_timer.wait_time = 8
		slimer_spawner_timer_2.wait_time = 12
		skeleton_spawner_timer.wait_time = 20
		golem_spawner_timer.wait_time = 30
	elif Global.score >= 300 && Global.score < 400:
		slime_spawner_timer.wait_time = 5
		slimer_spawner_timer_2.wait_time = 8
		skeleton_spawner_timer.wait_time = 15
		golem_spawner_timer.wait_time = 25


func _on_slime_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_slimer_spawner_timer_2_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_skeleton_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var skeleton = enemy_skeleton.instantiate()
	spawners[random_index].add_child(skeleton)

func _on_golem_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var golem = enemy_golem.instantiate()
	spawners[random_index].add_child(golem)
