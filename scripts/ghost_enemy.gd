extends CharacterBody2D

const SPEED = 50.0
const DETECTION_RANGE = 300
var target = null
@onready var ghost = $AnimatedSprite2D
@onready var damage_cooldown = $"Damage Cooldown"
@onready var death = $Death
@onready var fireball_timer = $"Fireball Timer"
@onready var damage_flash = $"Damage Flash"
@onready var nav_agent = $Naviguation/NavigationAgent2D
@onready var collision_shape_2d = $CollisionShape2D

var fireball_scene: PackedScene = preload("res://scenes/fireball.tscn")
const fireball_speed = 350

var health = 40
var player_range = false
var take_damage = true
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	ghost.play('default')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	deal_damage()
	update_health()
	
	if target and alive == true:
		var direction = (target.global_position - global_position).normalized()
		#velocity = direction * SPEED
		
		if nav_agent.is_navigation_finished():
			return
	
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = axis * SPEED
		flip_sprite(direction.x < 0)
	else:
		velocity = Vector2.ZERO
		
		
	move_and_slide()
	
func enemy():
	pass

func flip_sprite(flip):
	ghost.flip_h = flip
	
func deal_damage():
	if player_range and Global.player_current_attack == true and take_damage == true:
		health = health - 20
		take_damage = false
		damage_flash.play("damage")
		damage_cooldown.start()
		print('ghost health: ', health)
		if health <= 0: # Death
			Global.coins += generate_random_number()
			collision_shape_2d.visible = false
			Global.score += 10
			print(Global.coins)
			alive = false
			ghost.play('death')
			death.start()

func update_health():
	var healthbar = $Healthbar
	healthbar.value = health
	if health >= 40:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func generate_random_number():
	var random_number = randf()
	if random_number < 0.75:
		return 0
	elif random_number < 0.90:
		return 1
	else:  
		return 2


func _on_range_body_entered(body):
	if body.name == 'Main Character':
		target = body
		shoot()


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


func _on_hitbox_area_entered(area):
	if area.has_method("heal"):
		if health < 20:
			health = health + 20
		elif health < 40:
			health = 40
			
func shoot():
	if target:
		print('shoot2')
		var new_fireball = fireball_scene.instantiate() as RigidBody2D
		var fireball_position = $FireBallPosition.position
		new_fireball.position = fireball_position

		var direction = (target.global_position - global_position).normalized()

		new_fireball.gravity_scale = 0
		new_fireball.linear_velocity = direction * fireball_speed

		if ghost.flip_h:
			new_fireball.position.x = -15

		add_child(new_fireball)

		fireball_timer.start()

func _on_fireball_timer_timeout():
	print('shoot fireball')
	shoot()
