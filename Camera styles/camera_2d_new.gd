extends Camera2D

var lastRotationAngle = 0
var rotThreshold = 90

#var normal_zoom := Vector2(2,2)
#
#func targetting_mode(a: Vector2, b: Vector2):
	#var newFocus = (Vector2(EnemyManager.maxX,EnemyManager.maxY)+Vector2(EnemyManager.minX,EnemyManager.minY))*0.5
	#global_position = newFocus
	#
	#var rect = Rect2(Vector2(EnemyManager.minX,EnemyManager.minY),Vector2.ZERO)
	#rect = rect.expand(Vector2(EnemyManager.maxX,EnemyManager.maxY))
		#
	#var viewport_size = get_viewport_rect().size / normal_zoom
	#
	#var scale_x = rect.size.x / viewport_size.x
	#var scale_y = rect.size.y / viewport_size.y
	#
	#var scale = max(scale_x, scale_y)
	##because of the width/height resolution difference, it didn't work in other camera states. Now it sort of works, I have no idea why.
	#if Global.cameraState == 0 or Global.cameraState == 2:
		#zoom = normal_zoom / max(scale,1.0)
	#else:
		#zoom = normal_zoom / max(scale*1.78,1.0)
	#elif Global.cameraState == 1 or Global.cameraState == 3:
		#if scale > 1:
			#zoom = normal_zoom / max(scale,1.0) / 1.78
		#elif scale > 0.7:
			#zoom = normal_zoom / max(scale,1.0) / 1.4
		#else:
			#zoom = normal_zoom / max(scale,1.0)



func rotate_camera(clockwise: bool): #if true turn camera right, if false turn left
	if clockwise == true: 
		self.rotate(PI/2)
		Camera.cameraState = wrapf(Camera.cameraState+1,0,4)
		Movement.rotOffset += PI/2
		
	elif clockwise == false: 
		self.rotate(-PI/2)
		Camera.cameraState = wrapf(Camera.cameraState-1,0,4)
		Movement.rotOffset -= PI/2


func _ready():
	lastRotationAngle = Movement.cumulativeAngle

func _process(_delta):
	self.global_position = Movement.midpoint
	if round(Movement.cumulativeAngle) + lastRotationAngle == rotThreshold: 
		SignalBus.emit_signal("cameraRotated","right")
		rotate_camera(true)
		lastRotationAngle -= 90
		
	elif round(Movement.cumulativeAngle) + lastRotationAngle == -rotThreshold:
		SignalBus.emit_signal("cameraRotated","left")
		rotate_camera(false)
		lastRotationAngle += 90
		


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc") and $"Pause menu".hidden:
		get_tree().paused = true
		$"Pause menu".show()

	#if Input.is_action_pressed("TargettingMode"):
		#targetting_mode(Vector2(EnemyManager.minX,EnemyManager.minY),Vector2(EnemyManager.maxX,EnemyManager.maxY))
		#Global.targettingMode = true
		#Global.gameSpeed = 0.001
	#else:
		#zoom = normal_zoom
		#global_position = Global.midpoint
		#Global.targettingMode = false
