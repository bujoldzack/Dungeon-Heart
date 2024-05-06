extends Area2D

@onready var bwave = $BackWaveSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	bwave.play('BWave')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_wave_sprite_2d_animation_finished():
	queue_free()

func enemy():
	pass

func heal():
	pass
