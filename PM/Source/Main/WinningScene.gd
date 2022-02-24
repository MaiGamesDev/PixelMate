extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_MainMenu_button_up():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")
