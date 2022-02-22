extends Control

func _on_Bubble_resized() -> void:
	var bubble = $Message/Bubble
	
	if(bubble.rect_size.y > 50):
		rect_min_size.y = bubble.rect_size.y
