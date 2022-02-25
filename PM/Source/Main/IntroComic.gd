extends Node

onready var player = $AnimationPlayer

func play_intro():
	player.play("intro")

func next_scene():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")

func _on_MainMenu_button_up():
	player.play("fadeout")
