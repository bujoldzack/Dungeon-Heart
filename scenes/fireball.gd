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

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		queue_free()


func _on_despawn_timeout():
	queue_free()
