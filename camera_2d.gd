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
	
	#if camera state = 0 or 2?
	var scale = max(scale_x, scale_y)
	#else var scale = min(scale_x, scale_y)?
	
	zoom = normal_zoom / max(scale,1.0) 


func _process(delta):
	if Input.is_action_pressed("TargettingMode"):
		targetting_mode(Vector2(EnemyManager.minX,EnemyManager.minY),Vector2(EnemyManager.maxX,EnemyManager.maxY))
	else:
		zoom = normal_zoom
		global_position = Global.midpoint
