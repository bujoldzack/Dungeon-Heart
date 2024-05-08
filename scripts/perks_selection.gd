extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var shop_button = $"Shop Button"
@onready var heal_button = $"ColorRect/VBoxContainer/Heal Button"
@onready var speed_button = $"ColorRect/VBoxContainer/Speed Button"
@onready var damage_button = $"ColorRect/VBoxContainer/Damage Button"
@onready var resistance_button = $"ColorRect/VBoxContainer/Resistance Button"
@onready var rage_button = $"ColorRect/VBoxContainer/Rage Button"
@onready var speed_timer = $"Speed Timer"
@onready var damage_timer = $"Damage Timer"
@onready var resistance_timer = $"Resistance Timer"
@onready var rage_timer = $"Rage Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.coins < 20:
		heal_button.disabled = true
		speed_button.disabled = true
		damage_button.disabled = true
		resistance_button.disabled = true
		rage_button.disabled = true
	elif Global.coins < 35 and Global.coins >= 20:
		heal_button.disabled = false
		speed_button.disabled = false
		damage_button.disabled = false
		resistance_button.disabled = true
		rage_button.disabled = true
	elif Global.coins < 50 and Global.coins >= 35:
		heal_button.disabled = false
		speed_button.disabled = false
		damage_button.disabled = false
		resistance_button.disabled = false
		rage_button.disabled = true
	else:
		heal_button.disabled = false
		speed_button.disabled = false
		damage_button.disabled = false
		resistance_button.disabled = false
		rage_button.disabled = false

func _on_shop_button_pressed():
	color_rect.visible = true
	shop_button.visible = false

func _on_return_button_pressed():
	color_rect.visible = false
	shop_button.visible = true

func _on_heal_button_pressed():
	Global.coins = Global.coins - 20
	Global.health = 100

func _on_speed_button_pressed():
	Global.coins = Global.coins - 20
	Global.speed = 300
	speed_timer.start()

func _on_damage_button_pressed():
	Global.coins = Global.coins - 20
	Global.damage = 40
	damage_timer.start()

func _on_resistance_button_pressed():
	Global.coins = Global.coins - 35
	Global.health = 200
	resistance_timer.start()

func _on_rage_button_pressed():
	Global.coins = Global.coins - 50
	Global.health = 200
	Global.speed = 300
	Global.damage = 40
	rage_timer.start()

func _on_speed_timer_timeout():
	Global.speed = 150

func _on_damage_timer_timeout():
	Global.damage = 20

func _on_resistance_timer_timeout():
	Global.health = 100

func _on_rage_timer_timeout():
	Global.health = 100
	Global.speed = 150
	Global.damage = 20
