extends Node

var scene_path

func _ready():
	BGM.change_music("res://Sound/BGM/Regrets-David_Fesliyan.mp3")

func next_scene():
	get_tree().change_scene(scene_path)

func _on_Yes_button_up():
	scene_path = "res://Source/"
	if GameManager.last_scene == "":
		scene_path += "Main/LevelSelect.tscn"
	else:
		scene_path += GameManager.last_scene
	
	BGM.change_music("")
	$AnimationPlayer.play("fadeout")

func _on_No_button_up():
	scene_path = "res://Source/Main/MainMenu.tscn"
	$AnimationPlayer.play("fadeout")
