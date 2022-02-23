extends Node

export(PackedScene) var chat_scene
export(PackedScene) var player_chat_scene

var dialogues = []
var current_index = 0
var skip_line = 0
var current_affection = 0

var current_dialogue
var girl_portrait
var player_chat

onready var timer = $Timer

onready var scrollcon = $ChatArea
onready var chat_area = $ChatArea/VBoxContainer

onready var first_choice = $ChoiceButtons/FirstChoice
onready var second_choice = $ChoiceButtons/SecondChoice
onready var third_choice = $ChoiceButtons/ThirdChoice

onready var affection_progress = $AffectionMeter/Progress

func _ready() -> void:
	disable_buttons()
	
	$GirlCard/TextureRect.texture = GameManager.get_card_texture()
	girl_portrait = GameManager.get_portrait_texture()
	init(GameManager.get_dialogue_start())

func init(dialogue_file):
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		dialogues = parse_json(file.get_as_text())
		current_index = 0
	
	timer.start(2)
	yield(timer, "timeout")
	show_dialogue()

func show_dialogue():
	if not current_index >= len(dialogues["events"]):
		if dialogues["events"][current_index]["character"] == "Player":
			player_chat = player_chat_scene.instance()
			chat_area.add_child(player_chat)
			update_scroll()
	
			first_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][0]["text"]
			second_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][1]["text"]
			third_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][2]["text"]
			
			enable_buttons()
		else:
			var chat_object = chat_scene.instance()
			chat_object.init(girl_portrait)
			chat_area.add_child(chat_object)
			update_scroll()
			
			current_dialogue = dialogues["events"][current_index]["text"]
			
			if skip_line == 0:
				timer.start(current_dialogue.length() * 0.1)
				yield(timer, "timeout")
			
			chat_object.update_text(current_dialogue, skip_line)
			
			if chat_object.is_shown_all():
				timer.start(1)
				yield(timer, "timeout")
				
				skip_line = 0
				current_index += 1
				show_dialogue()
			else:
				skip_line += chat_object.get_max_line()
				show_dialogue()

func enable_buttons():
	first_choice.disabled = false;
	second_choice.disabled = false;
	third_choice.disabled = false;

func disable_buttons():
	first_choice.disabled = true;
	second_choice.disabled = true;
	third_choice.disabled = true;
	
	first_choice.get_node("Label").text = ""
	second_choice.get_node("Label").text = ""
	third_choice.get_node("Label").text = ""

func update_scroll():
	yield(get_tree(), "idle_frame")
	scrollcon.set_v_scroll(scrollcon.get_v_scrollbar().max_value)

func check_affection(affection):
	current_affection += affection
	
	if(current_affection < 0):
		current_affection = 0
	elif(current_affection > 100):
		current_affection = 100
	
	affection_progress.value = current_affection

func check_next(next):
	match next:
		"pass":
			current_index += 1
			show_dialogue()
		_:
			var next_dialogue = "res://Resource/Dialogues/" + next + ".json"
			init(next_dialogue)

func _on_FirstChoice_pressed() -> void:
	disable_buttons()
	player_chat.update_text(dialogues["events"][current_index]["choices"][0]["text"], 0)
	
	check_affection(dialogues["events"][current_index]["choices"][0]["affection"])
	check_next(dialogues["events"][current_index]["choices"][0]["next"])

func _on_SecondChoice_pressed() -> void:
	disable_buttons()
	player_chat.update_text(dialogues["events"][current_index]["choices"][1]["text"], 0)
	
	check_affection(dialogues["events"][current_index]["choices"][1]["affection"])
	check_next(dialogues["events"][current_index]["choices"][1]["next"])

func _on_ThirdChoice_pressed() -> void:
	disable_buttons()
	player_chat.update_text(dialogues["events"][current_index]["choices"][2]["text"], 0)
	
	check_affection(dialogues["events"][current_index]["choices"][2]["affection"])
	check_next(dialogues["events"][current_index]["choices"][2]["next"])
