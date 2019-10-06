extends KinematicBody2D

export var canMove : bool = true
export var speed : = 10

var destination = Vector2(0,0)
var path : PoolVector2Array


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
	# Hide selection sprite
	$Selection.hide()
	
	# Disable updates by default
	set_process(false)

func _process(delta):
    if canMove:
        $Sprite.flip_h = destination.x < position.x

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