extends Node

const erika_dialogue_start = "res://Resource/Dialogues/erika_start.json"
const minnie_dialogue_start = "res://Resource/Dialogues/minnie_start.json"
const hyuna_dialogue_start = "res://Resource/Dialogues/hyuna_start.json"

enum Girl {
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

export(Array, Texture) var girl_sprites

export(Array, MOVE) var effective_moves
export(Array, MOVE) var not_effective_moves

var selected_girl = Girl.ERIKA
var rng = RandomNumberGenerator.new()

var girls

func _ready() -> void:
	rng.randomize()
	girls = get_children()

func get_dialogue_start() -> String:
	match selected_girl:
		Girl.ERIKA:
			return erika_dialogue_start
		Girl.MINNIE:
			return minnie_dialogue_start
		Girl.HYUNA:
			return hyuna_dialogue_start
		_:
			return erika_dialogue_start

func get_card_texture() -> Texture:
	return girls[selected_girl].card_texture

func get_portrait_texture() -> Texture:
	return girls[selected_girl].portrait_texture

func get_girl_name() -> String:
	match selected_girl:
		Girl.ERIKA:
			return "Erika"
		Girl.MINNIE:
			return "Minnie"
		Girl.HYUNA:
			return "Hyuna"
		_:
			return "Erika"

func get_sprite_texture() -> Texture:
	return girl_sprites[selected_girl]

func get_effective_move() -> int:
	return effective_moves[selected_girl]

func get_not_effective_move() -> int:
	return not_effective_moves[selected_girl]

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

func get_girl_affection() -> String:
	return girls[selected_girl].affection_threshold
