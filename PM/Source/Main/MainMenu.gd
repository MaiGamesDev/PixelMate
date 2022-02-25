extends Node

func _on_Start_pressed():
	yield(get_tree().create_timer(0.15),"timeout")
	get_tree().change_scene("res://Source/Main/StartMenu.tscn")
