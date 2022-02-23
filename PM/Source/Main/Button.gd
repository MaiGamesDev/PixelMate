extends TextureButton

export(float) var pressed_space = 10
export(Texture) var released_texture
var texture_origin_y = 0
var label_origin_y = 0

func _ready():
	if $Texture != null:
		texture_origin_y = $Texture.rect_position.y
	if $Label != null:
		label_origin_y = $Label.rect_position.y
	
	connect("button_down",self,"_on_button_down")
	connect("button_up",self,"_on_button_up")

func _on_button_down():
	if $Texture != null:
		$Texture.rect_position.y = texture_origin_y + pressed_space
	if $Label != null:
		$Label.rect_position.y = label_origin_y + pressed_space

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

	if $Texture != null:
		$Texture.rect_position.y = texture_origin_y
	if $Label != null:
		$Label.rect_position.y = label_origin_y
