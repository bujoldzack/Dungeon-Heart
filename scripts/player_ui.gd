extends CanvasLayer

@onready var health_label = $HealthLabel
@onready var coin_label = $CoinLabel
@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_label.text = str(Global.health)
	coin_label.text = str(Global.coins)
	score_label.text = str(Global.score)
