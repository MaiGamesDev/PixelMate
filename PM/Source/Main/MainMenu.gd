extends Node

func _ready():
	BGM.change_music("res://Sound/BGM/late_night_radio_by_kevin_macleod_filmmusic.io.mp3")

func next_scene():
	get_tree().change_scene("res://Source/Main/LevelSelect.tscn")

func _on_Start_pressed():
	$AnimationPlayer.play("fadeout")
