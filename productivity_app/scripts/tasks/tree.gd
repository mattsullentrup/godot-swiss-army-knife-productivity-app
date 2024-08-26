extends Tree


func _ready() -> void:
	var tree := Tree.new()
	var root: TreeItem = tree.create_item()
	#tree.hide_root = true

	var child1: TreeItem = tree.create_item(root)
	child1.set_text(0, "Child1")

	var child2: TreeItem = tree.create_item(root)
	var subchild1: TreeItem = tree.create_item(child1)

	#var new_task: TreeItem = create_item(root)
	#root.add_child(new_task)

	# Allow text to be changed
	#new_task.set_editable(1, true)
	#new_task.set_text(1, "Tree - Child 1")

	#new_task.set_cell_mode(0, TreeItem.CELL_MODE_CHECK)


#func _on_item_selected() -> void:
	#var cell: TreeItem = get_selected()
#
	#if not cell.is_selected(0):
		#return
#
	#if cell.is_checked(0):
		#cell.set_checked(0, false)
	#elif cell.is_indeterminate(0):
		#cell.set_checked(0, true)
	#else:
		#cell.set_indeterminate(0, true)


func _on_new_project_button_pressed() -> void:
	pass # Replace with function body.
