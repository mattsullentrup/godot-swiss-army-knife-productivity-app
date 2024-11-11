extends VBoxContainer


@onready var _up_texture_rect: TextureRect = $UpTextureRect
@onready var _down_texture_rect: TextureRect = $DownTextureRect
@onready var _owner := get_owner()
@onready var _owner_parent := _owner.get_parent()


func _on_texture_rect_gui_input(event: InputEvent, texture_path: NodePath) -> void:
	var click := event as InputEventMouseButton
	if click and click.pressed:
		var texture: TextureRect = get_node(texture_path)
		if texture == _up_texture_rect:
			if not _owner.get_index() == 0:
				_owner_parent.move_child(_owner, _owner.get_index() - 1)
		elif texture == _down_texture_rect:
			if not _owner.get_index() == _owner_parent.get_child_count() - 1:
				_owner_parent.move_child(_owner, _owner.get_index() + 1)


func _on_texture_rect_mouse_entered(texture_path: NodePath) -> void:
	var texture: TextureRect = get_node(texture_path)
	print(texture)


func _on_texture_rect_mouse_exited(texture_path: NodePath) -> void:
	var texture: TextureRect = get_node(texture_path)
	pass
