extends Control

onready var typing_bubble = $TypingBubble
onready var bubble = $SpeechBubble
onready var message = $SpeechBubble/Label

func init(texture):
	$Portrait.texture = texture

func update_text(dialogue, skip_line):
	typing_bubble.visible = false
	bubble.visible = true
	message.text = dialogue
	message.lines_skipped = skip_line

func is_shown_all() -> bool:
	return message.max_lines_visible >= message.get_line_count() - message.lines_skipped

func get_max_line() -> int:
	return message.max_lines_visible
