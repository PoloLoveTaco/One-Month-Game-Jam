extends Control


func _on_general_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)


func _on_effect_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interfaces/main_menu.tscn")
