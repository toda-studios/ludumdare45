extends Camera2D


#-----------------#
# Camera Movement #
#-----------------#
export var xDeceleration = 48
export var yDecelration = 48

export var xCapSpeed = 8
export var yCapSpeed = 8
var cameraMovement = Vector2(0,0)

#-------------#
# Camera Zoom #
#-------------#
export var zoomDecelration = 4
export var zoomCapSpeed = 0.25

export var minZoom = 0.5
export var maxZoom = 2.5
var zoomChange = 0 


func _input(event):
	if event is InputEventMouseButton:
	    if event.is_pressed():
	        if event.button_index == BUTTON_WHEEL_UP:
	            zoomChange = -zoomCapSpeed
	        if event.button_index == BUTTON_WHEEL_DOWN:
	            zoomChange = zoomCapSpeed

func _process(delta):
	CameraMovement(delta)
	CameraZoom(delta)

func CameraMovement(delta):
	#Move camera depending on camera movement
	if(Input.is_action_pressed("ui_up")):
		cameraMovement.y = -yCapSpeed
	if(Input.is_action_pressed("ui_down")):
		cameraMovement.y = yCapSpeed
	if(Input.is_action_pressed("ui_left")):
		cameraMovement.x = -xCapSpeed
	if(Input.is_action_pressed("ui_right")):
		cameraMovement.x = xCapSpeed
	
	#Smooth camera to stop
	if(cameraMovement.x > 0):
		cameraMovement.x = clamp(cameraMovement.x - xDeceleration * delta, 0, xCapSpeed)
	elif(cameraMovement.x < 0):
		cameraMovement.x = clamp(cameraMovement.x + xDeceleration * delta, -xCapSpeed, 0)
	if(cameraMovement.y > 0):
		cameraMovement.y = clamp(cameraMovement.y - yDecelration * delta, 0, yCapSpeed)
	elif(cameraMovement.y < 0):
		cameraMovement.y = clamp(cameraMovement.y + yDecelration * delta, -yCapSpeed, 0)

	#Update player movement based on velocity
	position = position + cameraMovement
	
func CameraZoom(delta):
	if(zoomChange > 0):
		zoomChange = clamp(zoomChange - zoomDecelration * delta, 0, zoomCapSpeed)
	elif(zoomChange < 0):
		zoomChange = clamp(zoomChange + zoomDecelration * delta, -zoomCapSpeed, 0)
		
	zoom.x = clamp(zoom.x + zoomChange, minZoom, maxZoom)
	zoom.y = clamp(zoom.y + zoomChange, minZoom, maxZoom)