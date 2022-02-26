extends Node

enum GIRL {
	ERIKA,
	MINNIE,
	HYUNA
}

enum MOVE {
	FLIRT,
	LISTEN,
	HUMOUR,
	GIFT
}

enum GIRL_MOVE {
	LOW,
	HIGH,
	LISTEN,
	IGNORE
}

export(String, MULTILINE) var low_damage_text
export(String, MULTILINE) var high_damage_text
export(String, MULTILINE) var listen_text
export(String, MULTILINE) var ignore_text

var selected_girl = GIRL.ERIKA
var rng = RandomNumberGenerator.new()

var girls

func _ready() -> void:
	rng.randomize()
	girls = get_children()

func get_dialogue_start() -> String:
	return girls[selected_girl].dialogue_start_file

func get_card_texture() -> Texture:
	return girls[selected_girl].card_texture

func get_portrait_texture() -> Texture:
	return girls[selected_girl].portrait_texture

func get_girl_name() -> String:
	return girls[selected_girl].name

func get_sprite_texture() -> Texture:
	return girls[selected_girl].sprite_texture

func get_effective_move() -> int:
	return girls[selected_girl].effective_move

func get_not_effective_move() -> int:
	return girls[selected_girl].not_effective_move

func get_girl_move() -> int:
	return rng.randi_range(0, GIRL_MOVE.size() - 1)

func get_age(girl) -> int:
	return girls[girl].age

func get_girl_age() -> int:
	return get_age(selected_girl)

func get_description(girl) -> int:
	return girls[girl].short_description

func get_girl_description() -> int:
	return get_description(selected_girl)

func get_girl_success() -> String:
	return girls[selected_girl].date_success

func get_girl_fail() -> String:
	return girls[selected_girl].date_fail

func get_girl_affection() -> int:
	return girls[selected_girl].affection_threshold

func get_normal_text(move) -> String:
	var text = ""
	match move:
		MOVE.FLIRT:
			text = girls[selected_girl].flirt_texts[0]
		MOVE.LISTEN:
			text = girls[selected_girl].listen_texts[0]
		MOVE.HUMOUR:
			text = girls[selected_girl].humour_texts[0]
	return text

func get_effective_text(move) -> String:
	var text = ""
	match move:
		MOVE.FLIRT:
			text = girls[selected_girl].flirt_texts[1]
		MOVE.LISTEN:
			text = girls[selected_girl].listen_texts[1]
		MOVE.HUMOUR:
			text = girls[selected_girl].humour_texts[1]
		MOVE.GIFT:
			text = girls[selected_girl].gift_texts[0]
	return text

func get_not_effective_text(move) -> String:
	var text = ""
	match move:
		MOVE.FLIRT:
			text = girls[selected_girl].flirt_texts[2]
		MOVE.LISTEN:
			text = girls[selected_girl].listen_texts[2]
		MOVE.HUMOUR:
			text = girls[selected_girl].humour_texts[2]
		MOVE.GIFT:
			text = girls[selected_girl].gift_texts[1]
	return text
