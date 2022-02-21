extends TextureButton

export(float) var pressed_space = 10
var texture_origin_y = 0

func _ready():
	texture_origin_y = $Texture.rect_position.y
	
	connect("button_down",self,"_on_button_down")
	connect("button_up",self,"_on_button_up")

func _on_button_down():
	$Texture.rect_position.y = texture_origin_y + pressed_space

func _on_button_up():
	$Texture.rect_position.y = texture_origin_y
