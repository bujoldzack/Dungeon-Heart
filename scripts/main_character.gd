extends CharacterBody2D

const SPEED = 150.0
enum Direction { FRONT, BACK, SIDE }

var current_direction = Direction.FRONT
var previous_direction = Direction.FRONT
@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Vector2.ZERO
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
		velocity = direction * SPEED
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
	
	if current_direction != previous_direction:
		match current_direction:
			Direction.FRONT:
				anim.play("idle_back")
			Direction.BACK:
				anim.play("idle_front")
			Direction.SIDE:
				anim.play("idle_side")
	
	if velocity.length() > 0:
		match current_direction:
			Direction.FRONT:
				anim.play("run_back")
			Direction.BACK:
				anim.play("run_front")
			Direction.SIDE:
				anim.play("run_side")
	else:
		match previous_direction:
			Direction.FRONT:
				anim.play("idle_back")
			Direction.BACK:
				anim.play("idle_front")
			Direction.SIDE:
				anim.play("idle_side")

func flip_sprite(flip):
	anim.flip_h = flip
