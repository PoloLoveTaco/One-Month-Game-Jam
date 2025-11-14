extends Control

@onready var level_to_play: String


func _on_button_pressed() -> void:
	if level_to_play:
		get_tree().change_scene_to_file(level_to_play)


func _on_test_1_pressed() -> void:
	level_to_play = "res://Scenes/Maps/test.tscn"


func _on_test_2_pressed() -> void:
	level_to_play = "res://Scenes/Maps/test_2.tscn"
