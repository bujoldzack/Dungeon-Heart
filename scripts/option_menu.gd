extends Control

var language: String

var main_menu_scene = preload("res://scenes/main_menus.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SaveSystem.load_game_data_bytes()
	language = SaveSystem.save_dict.language
	TranslationServer.set_locale(language)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_back_button_m_pressed():
	#get_tree().change_scene_to_packed(main_menu_scene)
	$"../MainMenu".visible = true
	$".".visible = false

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

func _on_master_slider_value_changed(value):
	volume(0, value)

func _on_music_slider_value_changed(value):
	volume(1, value)

func _on_sound_fx_slider_value_changed(value):
	volume(2, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
