extends AudioStreamPlayer

onready var tween_out = get_node("Tween")

var next_stream = ""

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE

func change_music(music : String):
	if music == "":
		fade_out()
		yield($Tween, "tween_all_completed")
		return
	
	if stream == load(music):
		return
	
	fade_out()
	yield($Tween, "tween_all_completed")
	
	volume_db = 0
	stream = load(music)
	BGM.play()

func fade_out():
	tween_out.interpolate_property(self, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()

func _on_Tween_all_completed():
	pass
