extends RigidBody2D

@onready var despawn_timer = $Despawn

func _ready():
	despawn_timer.start() 

func _process(delta):
	pass

func enemy():
	pass
	
func ghost():
	pass

func _on_despawn_timeout():
	print('end')
	queue_free()

func _on_fire_ball_area_2d_body_entered(body):
	if not body.has_method("enemy"):
		queue_free()
