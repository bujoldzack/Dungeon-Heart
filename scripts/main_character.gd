extends CharacterBody2D

const SPEED = 150.0
const DAMAGE = 20
enum Direction { FRONT, BACK, SIDE }

var current_direction = Direction.FRONT
var previous_direction = Direction.FRONT
@onready var anim = $AnimatedSprite2D
@onready var cooldown = $Cooldown
@onready var attack_cooldown = $"Attack Cooldown"
@onready var damage_animation = $DamageAnimation
@onready var slash = $Slash

var max_slime = 5
var enemy_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false
var laser_beam = false


func _ready():
	Global.speed = SPEED
	Global.damage = DAMAGE

func _physics_process(delta):
	var direction = Vector2.ZERO

	enemy_attack()
	attack()
	
	if Input.is_action_just_pressed("coins"):
		Global.coins += 100
	
	if health <= 0:
		player_alive = false
		Global.dead = true
		get_tree().paused = true

	if player_alive == true:
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_up"):
			direction.y -= 1
		if Input.is_action_pressed("move_down"):
			direction.y += 1

		if direction.length() > 0:
			direction = direction.normalized()
			velocity = direction * Global.speed
		
			update_animation(direction)
			flip_sprite(direction.x < 0)
		else:
			velocity = Vector2.ZERO
			update_animation(Vector2.ZERO)
	
		move_and_slide()
	
func update_animation(direction):
	previous_direction = current_direction
	if direction.y > 0:
		current_direction = Direction.BACK
	elif direction.y < 0:
		current_direction = Direction.FRONT
	elif direction.x != 0:
		current_direction = Direction.SIDE
	
	if current_direction != previous_direction and attack_ip == false:
		match current_direction:
			Direction.FRONT:
				if attack_ip == false:
					anim.play("idle_back")
			Direction.BACK:
				if attack_ip == false:
					anim.play("idle_front")
			Direction.SIDE:
				if attack_ip == false:
					anim.play("idle_side")
				else:
					attack()
	
	if velocity.length() > 0 and attack_ip == false:
		match current_direction:
			Direction.FRONT:
				anim.play("run_back")
			Direction.BACK:
				anim.play("run_front")
			Direction.SIDE:
				anim.play("run_side")
	elif attack_ip == false:
		match previous_direction:
			Direction.FRONT:
				anim.play("idle_back")
			Direction.BACK:
				anim.play("idle_front")
			Direction.SIDE:
				anim.play("idle_side")

func flip_sprite(flip):
	anim.flip_h = flip

func _on_hitbox_body_entered(body):
	if body.has_method('enemy'):
		enemy_attack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method('enemy'):
		enemy_attack_range = false

func player():
	pass

func enemy_attack():
	if enemy_attack_range and enemy_attack_cooldown == true:
		if laser_beam:
			health = health - 40
		else:
			health = health - 5
		Global.health = health
		damage_animation.play("damage")
		enemy_attack_cooldown = false
		cooldown.start()
		print(health)

func attack():
	if Input.is_action_just_pressed('attack'):
		slash.play()
		Global.player_current_attack = true
		print('attack')
		attack_ip = true
		
		match current_direction:
			Direction.FRONT:
				anim.play("attack_back")
				attack_cooldown.start()
			Direction.BACK:
				anim.play("attack_front")
				attack_cooldown.start()
			Direction.SIDE:
				anim.play('attack_side')
				attack_cooldown.start()

func _on_cooldown_timeout():
	enemy_attack_cooldown = true
	damage_animation.stop()

func _on_attack_cooldown_timeout():
	attack_cooldown.stop()
	Global.player_current_attack = false
	attack_ip = false

func _on_hitbox_area_entered(area):
	if area.has_method('laser_BM'):
		enemy_attack_range = true
		laser_beam = true
	if area.has_method('enemy'):
		enemy_attack_range = true
	if area.has_method("fireball"):
		health = health - 10
		Global.health = health
		damage_animation.play("damage")
		enemy_attack_cooldown = false
		cooldown.start()
		print(health)

func _on_hitbox_area_exited(area):
	if area.has_method('laser_BM'):
		enemy_attack_range = false
		laser_beam = false
	if area.has_method('enemy'):
		enemy_attack_range = false
