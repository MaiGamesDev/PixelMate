extends AudioStreamPlayer



func _on_SoundPlayer_finished():
	queue_free()
