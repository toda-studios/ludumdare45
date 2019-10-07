extends Area2D

export var canMove : bool = true
export var speed : = 10

var destination = Vector2(0,0)
var path : PoolVector2Array
var nav2d : Navigation2D
var navId : String


func set_dest(new_path):
	destination = get_global_mouse_position()
	path = new_path
	if path.size() != 0:
		# If there is a movement path, enable updates
		set_process(true)
		
func on_select():
	$Selection.show()
	
func on_deselect():
	$Selection.hide()



	
func _ready() -> void:
	nav2d = get_node("/root").get_child(0)

	# Hide selection sprite
	$Selection.hide()
	
	# Disable updates by default
	set_process(false)

func _process(delta):
    if canMove:
        $Sprite.flip_h = destination.x < position.x

        check_location()
        # Move along provided movement path
        var move_distance = speed * delta
        move_along_path(move_distance)

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		
		# Move as close to next point as possible
		if distance <= distance_to_next and distance >= 0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		
		# Disable once complete
		elif distance < 0:
			position = path[0] # Avoid overshoot
			set_process(false)
			break
			
		# Find distance left
		distance -= distance_to_next
		
		# Change processing starting position
		start_point = path[0]
		
		# Remove processed point
		path.remove(0)

func check_location():
	var result = get_world_2d().direct_space_state.intersect_ray(destination, destination).get('collider')
	if(result):
		print(result)