extends Node

const erika_dialogue_start = "res://Resource/Dialogues/erika_start.json"
const minnie_dialogue_start = "res://Resource/Dialogues/minnie_start.json"
const hyuna_dialogue_start = "res://Resource/Dialogues/hyuna_start.json"

export(Array, Texture) var girl_cards

enum Girl {
	ERIKA,
	MINNIE,
	HYUNA
}

var selected_girl = Girl.ERIKA

func get_card_texture() -> Texture:
	return girl_cards[selected_girl]

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
