extends Node

var girl_labels = Array()

func _ready() -> void:
	girl_labels.append($VBoxContainer/Button/Erika/Label)
	girl_labels.append($VBoxContainer/Button/Minnie/Label)
	girl_labels.append($VBoxContainer/Button/Hyuna/Label)
	
	for girl in girl_labels.size():
		var text = String(GameManager.get_age(girl)) + " y/o\n"
		text += String(GameManager.get_description(girl))
		
		girl_labels[girl].text = text

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
