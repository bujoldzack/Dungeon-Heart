extends Area2D

@onready var fwave = $FrontWaveSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	fwave.play('FWave')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_front_wave_sprite_2d_animation_finished():
	queue_free()

func enemy():
	pass

func heal():
	pass
