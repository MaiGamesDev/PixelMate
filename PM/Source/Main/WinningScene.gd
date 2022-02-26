extends Node

func _ready():
	BGM.change_music("res://Sound/BGM/JPOP_FesliyanStudios_Steve_Oxen.mp3")

func play_intro():
	$AnimationPlayer.play("intro")

func next_scene():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")

func _on_MainMenu_button_up():
	$AnimationPlayer.play("fadeout")
