extends CharacterBody2D

const SPEED = 20.0
const DETECTION_RANGE = 300
var target = null

var laser_scene = preload("res://scenes/golem_laser.tscn")
var fwave_scene = preload("res://scenes/golem_fwave.tscn")
var bwave_scene = preload("res://scenes/golem_bwave.tscn")

@onready var golem = $AnimatedSprite2D
@onready var damage_cooldown = $"Damage Cooldown"
@onready var damage_flash = $"Damage Flash"
@onready var death = $Death
@onready var collision_shape_2d = $CollisionShape2D
@export var nav_agent: NavigationAgent2D

var health = 200
var player_range = false
var take_damage = true
var alive = true
var animation_locked = false
var movement = true
var direction = Vector2.ZERO

func _ready():
	set_process(true)
	nav_agent.path_desired_distance = 10
	nav_agent.target_desired_distance = 10

func _physics_process(delta):
	deal_damage()
	update_health()
	
	if target and alive == true:
		if movement:
			var direction = (target.global_position - global_position).normalized()
			
			if nav_agent.is_navigation_finished():
				return
			
			var axis = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = axis * SPEED
			
			if not animation_locked:
				update_animation(direction)
			
			flip_sprite(direction.x < 0)
			
			move_and_slide()
	else:
		velocity = Vector2.ZERO
		if not animation_locked:
			update_animation(Vector2.ZERO)

func update_animation(direction):
	if direction != Vector2.ZERO and alive == true:
		golem.play('running')
	elif alive == true:
		golem.play('idle')

func flip_sprite(flip):
	golem.flip_h = flip

#func enemy():
	#pass

func deal_damage():
	if player_range and Global.player_current_attack == true and take_damage == true:
		movement = false
		if not animation_locked:
			golem.play('damage')
			animation_locked = true
		health = health - 20
		take_damage = false
		damage_flash.play("damage")
		damage_cooldown.start()
		print('golem health: ', health)
		if health <= 0: # Death(
			Global.coins += generate_random_number()
			collision_shape_2d.visible = false
			Global.score += 100
			print(Global.coins)
			alive = false
			animation_locked = true
			golem.play('death')
			death.start()

func update_health():
	var healthbar = $Healthbar
	healthbar.value = health
	if health >= 200:
		healthbar.visible = false
	else:
		healthbar.visible = true

func generate_random_number():
	var random_number = randf()
	if random_number < 0.75:
		return 2
	elif random_number < 0.90:
		return 1
	else:  
		return 3

func _on_range_body_entered(body):
	if body.name == 'Main Character':
		target = body

func _on_range_body_exited(body):
	if body.name == 'Main Character':
		target = null

func _on_hitbox_body_entered(body):
	if body.has_method('player'):
		player_range = true

func _on_hitbox_body_exited(body):
	if body.has_method('player'):
		player_range = false

func _on_damage_cooldown_timeout():
	damage_flash.stop()
	take_damage = true

func _on_death_timeout():
	self.queue_free()

func _on_recalculate_timer_timeout():
	if target:
		nav_agent.target_position = target.global_position
	else:
		return

func _on_animated_sprite_2d_frame_changed():
	if golem.animation == 'attack_01':
		movement = false
		if golem.frame == 4:
			var new_laser = laser_scene.instantiate() as Area2D
			var laser_position = $SpawnLaser.position
			new_laser.position = laser_position
			if golem.flip_h:
				new_laser.scale.x = -1
				new_laser.position.x -= 5
			else:
				new_laser.scale.x = 1
			add_child(new_laser)
			print(golem.flip_h)
	
	if golem.animation == 'attack_02':
		movement = false
		if golem.frame == 8:
			var new_fwave = fwave_scene.instantiate() as Area2D
			var fwave_position = $SpawnFWave.position
			new_fwave.position = fwave_position
			if golem.flip_h:
				new_fwave.scale.x = -1
				new_fwave.position.x -= 45
			else:
				new_fwave.scale.x = 1
			add_child(new_fwave)
			
			var new_bwave = bwave_scene.instantiate() as Area2D
			var bwave_position = $SpawnBWave.position
			new_bwave.position = bwave_position
			if golem.flip_h:
				new_bwave.scale.x = -1
			else:
				new_bwave.scale.x = 1
			add_child(new_bwave)

func _on_animated_sprite_2d_animation_finished():
	if golem.animation == 'damage':
		print(animation_locked)
		animation_locked = false
		if not animation_locked:
			print('laser')
			animation_locked = true
			golem.play('attack_01')
	elif golem.animation == 'attack_01' or golem.animation == 'attack_02':
		movement = true
		animation_locked = false

func _on_shock_wave_interval_timeout():
	if not animation_locked:
		animation_locked = true
		golem.play('attack_02')
