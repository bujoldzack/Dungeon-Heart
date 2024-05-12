extends Node2D

var enemy_slime = preload("res://scenes/slime_enemy.tscn")
var enemy_skeleton = preload("res://scenes/enemy_skeleton_base.tscn")
var enemy_ghost = preload("res://scenes/ghost_enemy.tscn")
var spawners = []
@onready var slime_spawner_timer = $SlimeSpawnTimer0
@onready var slimer_spawner_timer_2 = $SlimeSpawnTimer1
@onready var skeleton_spawner_timer = $SkeletonSpawnTimer
@onready var ghost_spawner_timer = $GhostSpawnTimer
@onready var background_music = $"Background Music"

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = [$Spawners/Spawner1, $Spawners/Spawner2, $Spawners/Spawner3, $Spawners/Spawner4, $Spawners/Spawner5, $Spawners/Spawner6, $Spawners/Spawner7, $Spawners/Spawner8]
	Global.score = 0
	Global.coins = 0
	Global.health = 100
	Global.level = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.score >= 100 && Global.score < 300 :
		slime_spawner_timer.wait_time = 6
		slimer_spawner_timer_2.wait_time = 8
		skeleton_spawner_timer.wait_time = 12.5
		ghost_spawner_timer.wait_time = 20
	elif Global.score >= 300 && Global.score < 400:
		slime_spawner_timer.wait_time = 4
		slimer_spawner_timer_2.wait_time = 6
		skeleton_spawner_timer.wait_time = 10
		ghost_spawner_timer.wait_time = 15
	
	if not background_music.playing:
		background_music.play()

func _on_slime_spawn_timer_0_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_slime_spawn_timer_1_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_skeleton_spawn_timer_timeout():
	var random_index = randi() % spawners.size()
	var skeleton = enemy_skeleton.instantiate()
	spawners[random_index].add_child(skeleton)

func _on_ghost_spawn_timer_timeout():
	var random_index = randi() % spawners.size()
	var ghost = enemy_ghost.instantiate()
	spawners[random_index].add_child(ghost)
