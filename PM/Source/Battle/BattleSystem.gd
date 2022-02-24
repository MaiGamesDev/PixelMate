extends Node

export var base_damage = 20
export var girl_base_damage = 15

export(Array, String, MULTILINE) var flirt_texts
export(Array, String, MULTILINE) var listen_texts
export(Array, String, MULTILINE) var humour_texts
export(Array, String, MULTILINE) var gift_texts

var catched = false
var health = 100
var girl_health = 100
var rng = RandomNumberGenerator.new()

var move
var girl_name
var girl_effective_move
var girl_not_effective_move

onready var girl_sprite = $EnemyPlace/EnemyStanding
onready var girl_hp_bar = $EnemyStatePlace/EnemyHPBar/Progress
onready var hp_bar = $PlayerStatePlace/PlayerHPBar/Progress

onready var battle_log = $Footer/BattleLog
onready var battle_container = $Footer/BattleAction

onready var timer = $Timer

onready var capsule = $EnemyPlace/Capsule

func _ready() -> void:
	rng.randomize()
	girl_name = GameManager.get_girl_name()
	
	$EnemyStatePlace/Name.text = girl_name
	girl_sprite.texture = GameManager.get_sprite_texture()
	
	girl_effective_move = GameManager.get_effective_move()
	girl_not_effective_move = GameManager.get_not_effective_move()
	
	standby()

func standby():
	if girl_health == 0 or health == 0:
		timer.start(1.5)
		yield(timer, "timeout")
		
		get_tree().change_scene("res://Source/Main/GameOver.tscn")

	battle_log.hide()
	battle_container.show()

func play_turn():
#	if catched:
#		get_tree().change_scene("res://Source/Main/WinningScene.tscn")
	
	var text = ""
	var girl_move = GameManager.get_girl_move()
	
	battle_container.hide()
	
	match move:
		GameManager.MOVE.FLIRT:
			text = flirt_texts[rng.randi_range(0, flirt_texts.size() - 1)]
		GameManager.MOVE.LISTEN:
			text = listen_texts[rng.randi_range(0, listen_texts.size() - 1)]
		GameManager.MOVE.HUMOUR:
			text = humour_texts[rng.randi_range(0, humour_texts.size() - 1)]
		GameManager.MOVE.GIFT:
			text = gift_texts[rng.randi_range(0, gift_texts.size() - 1)]
	
	battle_log.text = text
	battle_log.show()
	
	timer.start(battle_log.text.length() * 0.05)
	yield(timer, "timeout")
	
	if move == girl_effective_move:
		battle_log.text = "It is effective!"
		
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			apply_damage(base_damage * 1.5)
			
			if girl_health == 0:
				standby()
				return
		
		timer.start(1.5)
		yield(timer, "timeout")
		
#		battle_log.text = effective_text
#
#		timer.start(battle_log.text.length() * 0.1)
#		yield(timer, "timeout")
	elif move == girl_not_effective_move:
		battle_log.text = "It is not effective!"
		
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			apply_damage(base_damage * 0.5)
			
			if girl_health == 0:
				standby()
				return
		
		timer.start(1.5)
		yield(timer, "timeout")
		
#		battle_log.text = not_effective_text
#
#		timer.start(battle_log.text.length() * 0.1)
#		yield(timer, "timeout")
	elif move != GameManager.MOVE.GIFT:
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			apply_damage(base_damage)
			
			if girl_health == 0:
				standby()
				return
		
#		battle_log.text = normal_text
#
#		timer.start(battle_log.text.length() * 0.1)
#		yield(timer, "timeout")
	
	match girl_move:
		GameManager.GIRL_MOVE.LOW:
			text = "She deals low damage."
			get_damage(girl_base_damage)
		GameManager.GIRL_MOVE.HIGH:
			text = "She deals high damage."
			get_damage(girl_base_damage * 1.5)
		GameManager.GIRL_MOVE.LISTEN:
			text = "She does nothing."
		GameManager.GIRL_MOVE.IGNORE:
			text = "She protects herself."
	
	battle_log.text = text
	
	timer.start(battle_log.text.length() * 0.05)
	yield(timer, "timeout")
	
	standby()

func player_action(move, text, effective_text = "", normal_text = "", not_effective_text = ""):
	if move == GameManager.MOVE.GIFT:
		yield(catch(), "completed")
	
	play_turn()

func apply_damage(value):
	var damage = rng.randf_range(value * 0.75, value * 1.25)
	
	girl_health -= damage
	if girl_health < 0:
		girl_health = 0
	
	girl_hp_bar.value = girl_health

func get_damage(value):
	var damage = rng.randf_range(value * 0.75, value * 1.25)
	
	health -= damage
	if health < 0:
		health = 0
	
	hp_bar.value = health

func catch():
	capsule.play("catch")
	
	timer.start(0.5)
	yield(timer, "timeout")
	
	girl_sprite.texture = null
	yield(capsule, "animation_finished")
	
	catched = true

func _on_Flirt_pressed() -> void:
	move = GameManager.MOVE.FLIRT
	play_turn()
#	player_action(
#		girl_name + " loves it so much.",
#		girl_name + " is shy.",
#		girl_name + " thinks you act too close."
#	)

func _on_Listen_pressed() -> void:
	move = GameManager.MOVE.LISTEN
	play_turn()
#	player_action(
#		girl_name + " feels she can depend on you.",
#		girl_name + " tells you her worries.",
#		girl_name + " doesn't tell you much."
#	)

func _on_Humour_pressed() -> void:
	move = GameManager.MOVE.HUMOUR
	play_turn()
#	player_action(
#		girl_name + " is loughing so hard.",
#		girl_name + " chuckles.",
#		girl_name + " says you are not funny."
#	)

func _on_Gift_pressed() -> void:
	move = GameManager.MOVE.GIFT
	play_turn()
