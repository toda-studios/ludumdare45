#------------------------------------------------
# Basic script that selects self when clicked on
#------------------------------------------------

extends Area2D

var controller

func _input_event(viewport, event, shape_idx):
	if(event.is_class("InputEventMouseButton")) \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		
		#If the controller is not found, find it.
		if !controller:
			var root = get_node('/root').get_child(1)
			for i in range(0, root.get_child_count()):
				var node = root.get_child(i)
				# Check if node has controller method
				if node.has_method("select_units"):
					controller = node
					break

		# If `CTRL` is pressed add unit
		if(Input.is_action_pressed("unit_additional_select")):
			controller.add_to_selection([get_parent()])
		
		# Otherwise, just select specified unit
		else:
			print(controller)
			controller.select_units([get_parent()])
