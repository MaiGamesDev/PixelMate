extends Node

onready var player = $AnimationPlayer

func _ready():
	BGM.stream = load("res://Sound/BGM/Regrets-David_Fesliyan.mp3")
	BGM.play()

func play_intro():
	player.play("intro")

func next_scene():
	get_tree().change_scene("res://Source/Main/MainMenu.tscn")

func _on_MainMenu_button_up():
	player.play("fadeout")
