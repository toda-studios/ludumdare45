extends AnimatedSprite


const WOBBLE_SPEED = 0.15 # Speed which the animation flips
export var rotationDegree : float = PI/16 # Degree of rotation in radians



var timer : Timer # Checks to update the wobble
var lastPos : Vector2 # Value to check

# Start the wobble!
func _ready():
    do_the_wobble()


func do_the_wobble():
    if lastPos:
        # If the parent moved
        if lastPos != get_parent().get_position():
            # Flip rotation
            if rotation_degrees < 0:
                rotation = rotationDegree
            else:
                rotation = -rotationDegree
        else:
            # Set rotation to 0 if no movement
            rotation = 0
    lastPos = get_parent().get_position()
    
    # Run the check timer
    if(!timer):
        timer = Timer.new()
        add_child(timer)
        timer.connect("timeout", self, "do_the_wobble")
    timer.start(WOBBLE_SPEED)
