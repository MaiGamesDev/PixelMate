extends Node

func next_scene():
	get_tree().change_scene("res://Source/Main/LevelSelect.tscn")

func _on_Start_pressed():
	$AnimationPlayer.play("fadeout")
