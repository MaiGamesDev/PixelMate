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

export(Array, Texture) var girl_cards
export(Array, Texture) var girl_portraits
export(Array, Texture) var girl_sprites

export(Array, MOVE) var effective_moves
export(Array, MOVE) var not_effective_moves

var selected_girl = Girl.ERIKA

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
	return girl_cards[selected_girl]

func get_portrait_texture() -> Texture:
	return girl_portraits[selected_girl]

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
