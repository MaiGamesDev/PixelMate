extends Node

enum MOVE {
	FLIRT,
	LISTEN,
	HUMOUR
}

export(int, 100) var age
export(String, FILE, "*.json") var dialogue_start_file
export(String, MULTILINE) var short_description

export(Texture) var card_texture
export(Texture) var portrait_texture
export(Texture) var sprite_texture

export(int, 100) var affection_threshold
export(Array, String, MULTILINE) var date_success
export(Array, String, MULTILINE) var date_fail

export(MOVE) var effective_move
export(MOVE) var not_effective_move

export(Array, String, MULTILINE) var flirt_texts
export(Array, String, MULTILINE) var listen_texts
export(Array, String, MULTILINE) var humour_texts
export(Array, String, MULTILINE) var gift_texts
