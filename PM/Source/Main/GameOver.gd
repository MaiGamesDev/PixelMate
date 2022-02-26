extends Node

var scene_path

func next_scene():
	get_tree().change_scene(scene_path)

func _on_Yes_button_up():
	scene_path = "res://Source/Main/LevelSelect.tscn"
	$AnimationPlayer.play("fadeout")

func _on_No_button_up():
	scene_path = "res://Source/Main/MainMenu.tscn"
	$AnimationPlayer.play("fadeout")
