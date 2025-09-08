extends Camera2D

var normal_zoom := Vector2(2,2)

func targetting_mode(a: Vector2, b: Vector2):
	var newFocus = (Vector2(EnemyManager.maxX,EnemyManager.maxY)+Vector2(EnemyManager.minX,EnemyManager.minY))*0.5
	global_position = newFocus
	
	var rect = Rect2(Vector2(EnemyManager.minX,EnemyManager.minY),Vector2.ZERO)
	rect = rect.expand(Vector2(EnemyManager.maxX,EnemyManager.maxY))
		
	var viewport_size = get_viewport_rect().size / normal_zoom
	
	var scale_x = rect.size.x / viewport_size.x
	var scale_y = rect.size.y / viewport_size.y
	
	var scale = max(scale_x, scale_y)
	#because of the width/height resolution difference, it didn't work in other camera states. Now it sort of works, I have no idea why.
	if Global.cameraState == 0 or Global.cameraState == 2:
		zoom = normal_zoom / max(scale,1.0)
	else:
		zoom = normal_zoom / max(scale*1.78,1.0)
	#elif Global.cameraState == 1 or Global.cameraState == 3:
		#if scale > 1:
			#zoom = normal_zoom / max(scale,1.0) / 1.78
		#elif scale > 0.7:
			#zoom = normal_zoom / max(scale,1.0) / 1.4
		#else:
			#zoom = normal_zoom / max(scale,1.0)



func _process(delta):
	#normalizing vector for camera states
	if Global.cameraState == 0:
		Global.VecRight = Vector2.RIGHT
		Global.VecLeft = Vector2.LEFT
		Global.VecUp = Vector2.UP
		Global.VecDown = Vector2.DOWN
	elif Global.cameraState == 1:
		Global.VecRight = Vector2.DOWN
		Global.VecLeft = Vector2.UP
		Global.VecUp = Vector2.RIGHT
		Global.VecDown = Vector2.LEFT
	elif Global.cameraState == 2:
		Global.VecRight = Vector2.LEFT
		Global.VecLeft = Vector2.RIGHT
		Global.VecUp = Vector2.DOWN
		Global.VecDown = Vector2.UP
	elif Global.cameraState == 3:
		Global.VecRight = Vector2.UP
		Global.VecLeft = Vector2.DOWN
		Global.VecUp = Vector2.LEFT
		Global.VecDown = Vector2.RIGHT


	if Input.is_action_pressed("TargettingMode"):
		targetting_mode(Vector2(EnemyManager.minX,EnemyManager.minY),Vector2(EnemyManager.maxX,EnemyManager.maxY))
		Global.targettingMode = true
	else:
		zoom = normal_zoom
		global_position = Global.midpoint
		Global.targettingMode = false
