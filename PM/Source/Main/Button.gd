extends TextureButton

export(float) var pressed_space = 10
export(Texture) var released_texture
var texture_origin_y = 0
var label_origin_y = 0

onready var texture = $Texture
onready var label = $Label

func _ready():
	if texture != null:
		texture_origin_y = texture.rect_position.y
	if label != null:
		label_origin_y = label.rect_position.y
	
	connect("button_down",self,"_on_button_down")
	connect("button_up",self,"_on_button_up")

func _on_button_down():
	if texture != null:
		texture.rect_position.y = texture_origin_y + pressed_space
	if label != null:
		label.rect_position.y = label_origin_y + pressed_space

func _on_button_up():
	if released_texture != null:
		self_modulate.a = 0
		var texture = Sprite.new()
		texture.texture = released_texture
		texture.centered = false
		texture.show_behind_parent = true
		add_child(texture)
		
		yield(get_tree().create_timer(0.15),"timeout")
		
		texture.queue_free()
		self_modulate.a = 100

	if texture != null:
		texture.rect_position.y = texture_origin_y
	if label != null:
		label.rect_position.y = label_origin_y
