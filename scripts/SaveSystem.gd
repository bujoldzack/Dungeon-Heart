extends Node

const savePath = "user://save_data.save"

var save_dict = {
	"language" : 'en'
}

func update_language(language: String):
	save_dict.language = language

func save_game_data():
	var save_file = FileAccess.open(savePath, FileAccess.WRITE)
	var json_data = JSON.stringify(save_dict)
	save_file.store_line(json_data)

func save_game_data_bytes():
	var save_file = FileAccess.open(savePath, FileAccess.WRITE)
	var save_bytes = var_to_bytes(save_dict)
	save_file.store_buffer(save_bytes)

func load_game_data():
	if not FileAccess.file_exists(savePath):
		return
	
	var save_file = FileAccess.open(savePath, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var parse_result = JSON.parse_string(json_string)
		print(parse_result)
		
		if parse_result:
			save_dict = parse_result

func load_game_data_bytes():
	if not FileAccess.file_exists(savePath):
		return
	
	var save_file = FileAccess.open(savePath, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
		var bytes = save_file.get_buffer(save_file.get_length())
		var parse_result = bytes_to_var(bytes)
		print(parse_result)
		
		if parse_result:
			save_dict = parse_result
