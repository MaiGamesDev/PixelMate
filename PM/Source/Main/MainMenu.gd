extends Node

func next_scene():
	get_tree().change_scene("res://Source/Main/StartMenu.tscn")

func _on_Start_pressed():
	$AnimationPlayer.play("fadeout")
