extends Control

var language: String

var main_menu_scene = preload("res://scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_back_button_m_pressed():
	get_tree().change_scene_to_packed(main_menu_scene)

func _on_english_button_pressed():
	TranslationServer.set_locale('en')
	language = "en"
	save()

func _on_spanish_button_pressed():
	TranslationServer.set_locale('es')
	language = "es"
	save()

func _on_french_button_pressed():
	TranslationServer.set_locale('fr')
	language = "fr"
	save()

func save():
	SaveSystem.update_language(language)
	SaveSystem.save_game_data_bytes()
