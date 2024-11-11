extends VBoxContainer


@onready var _up_texture_rect: TextureRect = $UpTextureRect
@onready var _down_texture_rect: TextureRect = $DownTextureRect


func _on_texture_rect_gui_input(event: InputEvent, texture_path: NodePath) -> void:
	var click := event as InputEventMouseButton
	if click:
		pass


func _on_texture_rect_mouse_entered(texture_path: NodePath) -> void:
	var texture: TextureRect = get_node(texture_path)
	print(texture)


func _on_texture_rect_mouse_exited(texture_path: NodePath) -> void:
	pass
