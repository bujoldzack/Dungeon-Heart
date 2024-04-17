extends CharacterBody2D

const SPEED = 50.0
const DETECTION_RANGE = 300
var target = null
@onready var slime = $AnimatedSprite2D
@onready var damage_cooldown = $"Damage Cooldown"
@onready var death = $Death

var health = 100
var player_range = false
var take_damage = true
var alive = true

func _ready():
	set_process(true)

func _physics_process(delta):
	
	deal_damage()
	
	if target and alive == true:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * SPEED
		update_animation(direction)
		flip_sprite(direction.x < 0)
	else:
		velocity = Vector2.ZERO
		update_animation(Vector2.ZERO)
		
		
	move_and_slide()

func update_animation(direction):
	if direction != Vector2.ZERO and alive == true:
		slime.play('running_side')
	elif alive == true:
		slime.play('idle')

func flip_sprite(flip):
	slime.flip_h = flip

func _on_range_body_entered(body):
	if body.name == 'Main Character':
		target = body

func _on_range_body_exited(body):
	if body.name == 'Main Character':
		target = null

func enemy():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method('player'):
		player_range = true

func _on_hitbox_body_exited(body):
	if body.has_method('player'):
		player_range = false
		
func deal_damage():
	if player_range and Global.player_current_attack == true and take_damage == true:
		health = health - 20
		take_damage = false
		damage_cooldown.start()
		print('slime health: ', health)
		if health <= 0:
			alive = false
			slime.play('death')
			death.start()

func _on_damage_cooldown_timeout():
	take_damage = true

func _on_death_timeout():
	self.queue_free()
