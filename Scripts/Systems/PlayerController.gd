extends Node2D


#Units loop through when giving actions
var selectedUnits = []
var lastSelectTime 

func _process(delta):
	
	# Deselect units with there is a mouse click
	if(Input.is_action_just_pressed("unit_select")):
		if(lastSelectTime):
			if lastSelectTime <= OS.get_unix_time() - 1:
				select_units([])
		else:
			select_units([])
	
	# On rightclick/action button
	elif(Input.is_action_just_pressed("unit_action")):
		print("Setting dest for " + str(len(selectedUnits)) + " objects.")
		
		var dest = get_global_mouse_position()
		var nav2d : Navigation2D = get_node("/root").get_child(0).get_node("Navigation2D")
		
		for unit in selectedUnits:
			if(unit.has_method("set_dest")):
				# Generate navigation path based on provided nav2d
				var path : = nav2d.get_simple_path(unit.global_position, get_global_mouse_position())
				
				# Call movement function on unit
				unit.set_dest(path)
			else:
				# Give warning if object has no movement function
				print("WARNING: Attempting to set destintation for non-unit object!")
				
				
# Replace selected units with given units
func select_units(units):
	
	# Used to calculate deselection
	lastSelectTime = OS.get_unix_time()

	var remove_units = []
	
	# Find units that will no longer be selected
	for unit in selectedUnits:
		if not unit in units:
			remove_units.append(unit)

	# Remove newly unselected units and called `on_deselect()`
	for unit in remove_units:
		selectedUnits.remove(selectedUnits.find(unit))
		if(unit.has_method("on_deselect")):
			unit.on_deselect()
		print("Deselected: " + str(unit.name))
				
	# Add newly selected units and call `on_select()`
	for unit in units:
		if not unit in selectedUnits:
			selectedUnits.append(unit)
			if(unit.has_method("on_select")):
				unit.on_select()
			print("Selected: " + str(unit.name))
			
# Adds units to selection without reseting list
func add_to_selection(units):
	select_units(selectedUnits + units)
	
	
			