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
	new_task.set_editable(0, true)
	new_task.set_text(0, "Tree - Child 1")

	new_task.set_cell_mode(1, 1)
	#var texture : CompressedTexture2D = load("res://addons/images/go_back.png")
	#new_task.add_button(1, texture)
