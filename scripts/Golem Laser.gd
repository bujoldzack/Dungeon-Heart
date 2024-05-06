extends Area2D

@onready var laser = $LaserSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	laser.play('Shoot')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_laser_sprite_animation_finished():
	queue_free()

func laser_BM():
	pass
