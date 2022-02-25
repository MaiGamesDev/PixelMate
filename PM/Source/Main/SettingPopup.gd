extends Control

export var audio_bus_name := "Master"
onready var _bus := AudioServer.get_bus_index(audio_bus_name)

var volume = 0

func _ready():
	hide()
	
	$VBox/HBox/VBox/Fullscreen.pressed = OS.window_fullscreen
	volume = db2linear(AudioServer.get_bus_volume_db(_bus))
	$VBox/HBox/VBox2/Volume.text = str(volume * 100)

func _on_Setting_pressed():
	show()

func _on_Close_pressed():
	hide()

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed

func _on_VolumeUp_pressed():
	volume = clamp(volume + 0.05, 0, 1)
	AudioServer.set_bus_volume_db(_bus, linear2db(volume))
	$VBox/HBox/VBox2/Volume.text = str(volume * 100)

func _on_VolumeDown_pressed():
	volume = clamp(volume - 0.05, 0, 1)
	AudioServer.set_bus_volume_db(_bus, linear2db(volume))
	$VBox/HBox/VBox2/Volume.text = str(volume * 100)
