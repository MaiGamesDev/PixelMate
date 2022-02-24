extends Node

export var base_damage = 20

var player_turn = true

var girl_name
var girl_health
var girl_effective_move
var girl_not_effective_move

onready var girl_hp_bar = $EnemyStatePlace/EnemyHPBar/Progress

onready var battle_log = $Footer/BattleLog
onready var battle_container = $Footer/BattleAction

onready var timer = $Timer

func _ready() -> void:
	girl_health = 100
	girl_name = GameManager.get_girl_name()
	
	$EnemyStatePlace/Name.text = girl_name
	$EnemyPlace/EnemyStanding.texture = GameManager.get_sprite_texture()
	
	girl_effective_move = GameManager.get_effective_move()
	girl_not_effective_move = GameManager.get_not_effective_move()
	
	play_turn()

func play_turn():
#	if girl_health == 0:
#		get_tree().change_scene("res://Source/Main/GameOver.tscn")
	
	if player_turn:
		battle_log.hide()
		battle_container.show()

func player_action(move, text, effective_text = "", normal_text = "", not_effective_text = ""):
	#player_turn = false
	battle_container.hide()
	
	battle_log.text = text
	battle_log.show()
	
	timer.start(battle_log.text.length() * 0.1)
	yield(timer, "timeout")
	
	if move == girl_effective_move:
		battle_log.text = "It is effective!"
		
		apply_damage(base_damage * 1.5)
		
		timer.start(battle_log.text.length() * 0.1)
		yield(timer, "timeout")
		
		battle_log.text = effective_text
		
		timer.start(battle_log.text.length() * 0.1)
		yield(timer, "timeout")
	elif move == girl_not_effective_move:
		battle_log.text = "It is not effective!"
		
		apply_damage(base_damage * 0.5)
		
		timer.start(battle_log.text.length() * 0.1)
		yield(timer, "timeout")
		
		battle_log.text = not_effective_text
		
		timer.start(battle_log.text.length() * 0.1)
		yield(timer, "timeout")
	else:
		battle_log.text = normal_text
		
		apply_damage(base_damage)
		
		timer.start(battle_log.text.length() * 0.1)
		yield(timer, "timeout")
	
	play_turn()

func apply_damage(value):
	girl_health -= value
	if girl_health < 0:
		girl_health = 0
	
	girl_hp_bar.value = girl_health

func _on_Flirt_pressed() -> void:
	player_action(
		GameManager.MOVE.FLIRT, 
		"You try to Flirt.",
		girl_name + " loves it so much.",
		girl_name + " is shy.",
		girl_name + " thinks you act too close."
	)

func _on_Listen_pressed() -> void:
	player_action(
		GameManager.MOVE.LISTEN,
		"You offer your ear to listen her.",
		girl_name + " feels she can depend on you.",
		girl_name + " tells you her worries.",
		girl_name + " doesn't tell you much."
	)

func _on_Humour_pressed() -> void:
	player_action(
		GameManager.MOVE.HUMOUR,
		"You make a joke.",
		girl_name + " is loughing so hard.",
		girl_name + " chuckles.",
		girl_name + " says you are not funny."
	)

func _on_Gift_pressed() -> void:
	player_action(GameManager.MOVE.GIFT, "You give her a gift and ask her to go out")
