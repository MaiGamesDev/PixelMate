extends Node

func _on_MainMenu_button_up():
	yield(get_tree().create_timer(0.15),"timeout")
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")
