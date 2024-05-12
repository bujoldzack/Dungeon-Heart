extends Node2D

var enemy_slime = preload("res://scenes/slime_enemy.tscn")
var enemy_skeleton = preload("res://scenes/enemy_skeleton_base.tscn")
var enemy_ghost = preload("res://scenes/ghost_enemy.tscn")
var enemy_golem = preload("res://scenes/golem_enemy.tscn")
var spawners = []
@onready var slime_spawner_timer = $SlimeSpawnerTimer0
@onready var slimer_spawner_timer_2 = $SlimeSpawnerTimer1
@onready var skeleton_spawner_timer = $SqueletonSpawnerTimer
@onready var ghost_spawner_timer = $GhostSpawnerTimer
@onready var golem_spawner_timer = $GolemSpawnerTimer
@onready var background_music = $"Background Music"

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = [$Spawners/Spawner1, $Spawners/Spawner2, $Spawners/Spawner3, $Spawners/Spawner6, $Spawners/Spawner7, $Spawners/Spawner8, $Spawners/Spawner9, $Spawners/Spawner10, $Spawners/Spawner11, $Spawners/Spawner12, $Spawners/Spawner13, $Spawners/Spawner14, $Spawners/Spawner15, $Spawners/Spawner16, $Spawners/Spawner17, $Spawners/Spawner18]
	Global.score = 0
	Global.coins = 0
	Global.health = 100
	Global.level = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.score >= 100 && Global.score < 300 :
		slime_spawner_timer.wait_time = 4.5
		slimer_spawner_timer_2.wait_time = 6
		skeleton_spawner_timer.wait_time = 7.5
		ghost_spawner_timer.wait_time = 10.5
		golem_spawner_timer.wait_time = 15
	elif Global.score >= 300 && Global.score < 400:
		slime_spawner_timer.wait_time = 3
		slimer_spawner_timer_2.wait_time = 4
		skeleton_spawner_timer.wait_time = 5
		ghost_spawner_timer.wait_time = 7
		golem_spawner_timer.wait_time = 10
	
	if not background_music.playing:
		background_music.play()


func _on_slime_spawner_timer_0_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_slime_spawner_timer_1_timeout():
	var random_index = randi() % spawners.size()
	var slime = enemy_slime.instantiate()
	spawners[random_index].add_child(slime)

func _on_squeleton_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var skeleton = enemy_skeleton.instantiate()
	spawners[random_index].add_child(skeleton)

func _on_ghost_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var ghost = enemy_ghost.instantiate()
	spawners[random_index].add_child(ghost)

func _on_golem_spawner_timer_timeout():
	var random_index = randi() % spawners.size()
	var golem = enemy_golem.instantiate()
	spawners[random_index].add_child(golem)
