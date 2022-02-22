extends Node

export(PackedScene) var chat_scene
export(PackedScene) var player_chat_scene
export(String, FILE, "*.json") var start_dialogue_file

var dialogues = []
var current_index = 0

onready var scrollcon = $ChatArea
onready var chat_area = $ChatArea/VBoxContainer
onready var first_choice = $Choices/First
onready var second_choice = $Choices/Second
onready var third_choice = $Choices/Third

func _ready() -> void:
	init(start_dialogue_file)

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ui_accept")):
		show_dialogue()

func init(dialogue_file):
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		dialogues = parse_json(file.get_as_text())
		current_index = 0

func show_dialogue() -> void:
	if not current_index >= len(dialogues["events"]):
		if dialogues["events"][current_index]["character"] == "Player":
			first_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][0]["text"]
			second_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][1]["text"]
			third_choice.get_node("Label").text = dialogues["events"][current_index]["choices"][2]["text"]
			enable_buttons()
		else:
			var chat_object = chat_scene.instance()
			chat_area.add_child(chat_object)
			chat_object.get_node("Message").text = dialogues["events"][current_index]["text"]
			current_index += 1
			
			yield(get_tree(), "idle_frame")
			scrollcon.set_v_scroll(scrollcon.get_v_scrollbar().max_value)

func enable_buttons():
	first_choice.disabled = false;
	second_choice.disabled = false;
	third_choice.disabled = false;

func disable_buttons():
	first_choice.disabled = true;
	second_choice.disabled = true;
	third_choice.disabled = true;

func _on_First_pressed() -> void:
	var chat_object = player_chat_scene.instance()
	chat_area.add_child(chat_object)
	chat_object.get_node("Message").text = dialogues["events"][current_index]["choices"][0]["text"]
	
	disable_buttons()
	yield(get_tree(), "idle_frame")
	scrollcon.set_v_scroll(scrollcon.get_v_scrollbar().max_value)
	
	var next_dialogue = "res://Resource/Dialogues/" + dialogues["events"][current_index]["choices"][0]["next"] + ".json"
	init(next_dialogue)
	
func _on_Second_pressed() -> void:
	var chat_object = player_chat_scene.instance()
	chat_area.add_child(chat_object)
	chat_object.get_node("Message").text = dialogues["events"][current_index]["choices"][1]["text"]
	
	disable_buttons()
	yield(get_tree(), "idle_frame")
	scrollcon.set_v_scroll(scrollcon.get_v_scrollbar().max_value)
	
	var next_dialogue = "res://Resource/Dialogues/" + dialogues["events"][current_index]["choices"][1]["next"] + ".json"
	init(next_dialogue)

func _on_Third_pressed() -> void:
	var chat_object = player_chat_scene.instance()
	chat_area.add_child(chat_object)
	chat_object.get_node("Message").text = dialogues["events"][current_index]["choices"][2]["text"]
	
	disable_buttons()
	yield(get_tree(), "idle_frame")
	scrollcon.set_v_scroll(scrollcon.get_v_scrollbar().max_value)
	
	var next_dialogue = "res://Resource/Dialogues/" + dialogues["events"][current_index]["choices"][2]["next"] + ".json"
	init(next_dialogue)
