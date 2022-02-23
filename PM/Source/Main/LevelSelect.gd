extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fadein")

func next_scene():
	get_tree().change_scene("res://Source/Chat/ChatRoom.tscn")

func _on_Erika_pressed():
	$AnimationPlayer.play("fadeout")
	GameManager.selected_girl = GameManager.Girl.ERIKA

func _on_Minnie_pressed():
	$AnimationPlayer.play("fadeout")
	GameManager.selected_girl = GameManager.Girl.MINNIE

func _on_Hyuna_pressed():
	$AnimationPlayer.play("fadeout")
	GameManager.selected_girl = GameManager.Girl.HYUNA
