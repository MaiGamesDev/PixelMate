extends Node

var is_started = false

func go_levelSelect():
	get_tree().change_scene("res://Source/Main/LevelSelect.tscn")

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if !is_started:
			$AnimationPlayer.play("start")
			is_started = true
