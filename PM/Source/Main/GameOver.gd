extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Yes_button_up():
	get_tree().change_scene("res://Source/Main/LevelSelect.tscn")


func _on_No_button_up():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")
