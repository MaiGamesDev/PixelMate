extends Node

func _on_Yes_button_up():
	get_tree().change_scene("res://Source/Main/LevelSelect.tscn")

func _on_No_button_up():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")
