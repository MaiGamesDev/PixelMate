extends Node

onready var battle_info = $Footer/BattleInfo

func _on_Flirt_pressed() -> void:
	battle_info.text = "You try to Flirt"

func _on_Listen_pressed() -> void:
	battle_info.text = "You offer your ear to listen her"

func _on_Humour_pressed() -> void:
	battle_info.text = "You make a horrible joke"

func _on_Gift_pressed() -> void:
	battle_info.text = "You give her a gift and ask her to go out"
