@tool
extends Tree


func _ready() -> void:
	var root: TreeItem = create_item()
	root.set_text(0, "Tree - Root")
	#var child1: TreeItem = create_item(root)
	#child1.set_text(0, "Tree - Child 1")
	#var child2: TreeItem = create_item(root)
	#child2.set_text(0, "Tree - Child 2")
	#var subchild1: TreeItem = create_item(child1)
	#subchild1.set_text(0, "Tree - Subchild 1")

	var new_task : TreeItem = create_item(root)
	#root.add_child(new_task)

	# Allow text to be changed
	new_task.set_editable(1, true)
	new_task.set_text(1, "Tree - Child 1")

	new_task.set_cell_mode(0, TreeItem.CELL_MODE_CHECK)
	#var texture : CompressedTexture2D = load("res://addons/images/go_back.png")
	#new_task.add_button(1, texture)


func _on_cell_selected() -> void:
	var item : TreeItem = get_selected()
	if item.is_checked(0):
		item.set_checked(0, false)
	elif item.is_indeterminate(0):
		item.set_checked(0, true)
	else:
		item.set_indeterminate(0, true)
