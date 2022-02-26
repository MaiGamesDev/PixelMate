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
var next_scene_path

onready var girl_sprite = $EnemyPlace/EnemyStanding
onready var girl_hp_bar = $EnemyStatePlace/EnemyHPBar/Progress
onready var hp_bar = $PlayerStatePlace/PlayerHPBar/Progress

onready var battle_log = $Footer/BattleLog
onready var battle_container = $Footer/BattleAction

onready var timer = $Timer

onready var capsule_player = $EnemyPlace/AnimationPlayer

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
		next_scene_path = "res://Source/Main/GameOver.tscn"
		$AnimationPlayer.play("fadeout")
	
	if catched:
		timer.start(1.5)
		yield(timer, "timeout")
		next_scene_path = "res://Source/Main/WinningScene.tscn"
		$AnimationPlayer.play("fadeout")
	else:
		battle_log.hide()
		battle_container.show()

func play_turn():
	var text = ""
	var girl_move = GameManager.get_girl_move()
	
	play_skill_sound()
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
	
	yield(wait(battle_log.text.length() * 0.08), "completed")
	
	if move == girl_effective_move:
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			battle_log.text = "It is effective! " + GameManager.get_effective_text(move)
			
			apply_damage(base_damage * 1.5)
			if girl_health == 0:
				standby()
				return
			
			yield(wait(battle_log.text.length() * 0.08), "completed")
	elif move == girl_not_effective_move:
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			battle_log.text = "It is not effective! " + GameManager.get_not_effective_text(move)
			
			apply_damage(base_damage * 0.5)
			if girl_health == 0:
				standby()
				return
			
			yield(wait(battle_log.text.length() * 0.08), "completed")
	elif move != GameManager.MOVE.GIFT:
		if girl_move != GameManager.GIRL_MOVE.IGNORE:
			battle_log.text = GameManager.get_normal_text(move)
			
			apply_damage(base_damage)
			if girl_health == 0:
				standby()
				return
			
			yield(wait(battle_log.text.length() * 0.08), "completed")
	else:
		yield(catch(), "completed")
		
		if catched:
			battle_log.text = GameManager.get_effective_text(move)
			yield(wait(battle_log.text.length() * 0.08), "completed")
			standby()
			return
		else:
			battle_log.text = GameManager.get_not_effective_text(move)
			yield(wait(battle_log.text.length() * 0.08), "completed")
	
	match girl_move:
		GameManager.GIRL_MOVE.LOW:
			text = GameManager.low_damage_text
			get_damage(girl_base_damage)
		GameManager.GIRL_MOVE.HIGH:
			text = GameManager.high_damage_text
			get_damage(girl_base_damage * 1.5)
		GameManager.GIRL_MOVE.LISTEN:
			text = GameManager.listen_text
		GameManager.GIRL_MOVE.IGNORE:
			text = GameManager.ignore_text
	
	battle_log.text = text
	
	yield(wait(battle_log.text.length() * 0.08), "completed")
	
	standby()

func wait(time):
	if time < 2:
		time = 2
	
	timer.start(time)
	yield(timer, "timeout")

func apply_damage(value):
	var damage = rng.randf_range(value * 0.75, value * 1.25)
	
	girl_health -= damage
	if girl_health < 0:
		girl_health = 0
	
	girl_hp_bar.value = girl_health
	play_hurt_sound()

func get_damage(value):
	var damage = rng.randf_range(value * 0.75, value * 1.25)
	
	health -= damage
	if health < 0:
		health = 0
	
	hp_bar.value = health
	play_hurt_sound()

func catch():
	var m = rng.randi_range(0, 255)
	
	var health_thres = 100 - GameManager.get_girl_affection()
	var f = (100 * 255 * health_thres) / (girl_health * 100)
	
	play_throw_sound()
	capsule_player.play("catch")
	yield(capsule_player, "animation_finished")
	
	if f >= m:
		catched = true
		
		for i in 3:
			play_shake_sound()
			capsule_player.play("shake")
			yield(capsule_player, "animation_finished")
		
		play_win_sound()
		capsule_player.play("success")
		yield(capsule_player, "animation_finished")
	else:
		var shakes = rng.randi_range(0, 3)
		
		for i in shakes:
			play_shake_sound()
			capsule_player.play("shake")
			yield(capsule_player, "animation_finished")
		
		play_fail_sound()
		capsule_player.play("fail")
		yield(capsule_player, "animation_finished")

func next_scene():
	get_tree().change_scene(next_scene_path)

func play_hurt_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Hurt.mp3")
	
	add_child(sound)
	
func play_skill_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Gage_up.wav")
	
	add_child(sound)
	
func play_throw_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Ball_throw.wav")
	
	add_child(sound)
	
func play_shake_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Ball_shake.wav")
	
	add_child(sound)
	
func play_fail_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Catch_fail.wav")
	
	add_child(sound)
	
func play_win_sound():
	var sound = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound.stream = load("res://Sound/SFX/Gotcha.wav")
	
	var sound2 = load("res://Source/Audio/SoundPlayer.tscn").instance()
	sound2.stream = load("res://Sound/SFX/You_win.mp3")
	
	add_child(sound)
	add_child(sound2)

func _on_Flirt_pressed() -> void:
	move = GameManager.MOVE.FLIRT
	play_turn()

func _on_Listen_pressed() -> void:
	move = GameManager.MOVE.LISTEN
	play_turn()

func _on_Humour_pressed() -> void:
	move = GameManager.MOVE.HUMOUR
	play_turn()

func _on_Gift_pressed() -> void:
	move = GameManager.MOVE.GIFT
	play_turn()
