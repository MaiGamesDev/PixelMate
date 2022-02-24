extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("intro")


func _on_MainMenu_button_up():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")
